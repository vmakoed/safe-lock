extends BaseLevel

const INITIAL_SELECTED_INDEX = 0
const CONTROLS_HINT_ACTIVE_PIECE = "◀▶▲▼: MOVE / A: CONFIRM / X: REMOVE / B: BACK"
const CONTROLS_HINT_NEW_PIECE = "◀▶: SELECT / A: ADD / B: BACK"
const CONTROLS_HINT_EXISTING_PIECE = "◀▶: SELECT / A: MOVE / X: REMOVE / B: BACK"

@export var cell_size: Vector2i = Vector2i(128, 128)
@export var grid_size: Vector2i = Vector2i(5, 4)

@onready var board := %Board
@onready var panels_container := %Panels

var active_piece: Control = null
var panels: Array[SelectablePanel] = []
var selected_index := INITIAL_SELECTED_INDEX: set = _set_selected_index

func _ready() -> void:
	_load_panels()
	_update_panels()
	_update_controls_hint()

func handle_input(action: String) -> void:
	match action:
		"up": _on_up_pressed()
		"left": _on_left_pressed()
		"down": _on_down_pressed()
		"right": _on_right_pressed()
		"a": _on_confirm_pressed()
		"b": _on_back_button_pressed()
		"x": _on_remove_pressed()

func _move_selection(direction: int) -> void:
	selected_index = wrapi(selected_index + direction, 0, panels.size())
	_update_controls_hint()

func _set_selected_index(digit_index: int) -> void:
	selected_index = digit_index
	_update_panels()

func _load_panels() -> void:
	for i in range(panels_container.get_child_count()):
		var panel = panels_container.get_child(i)
		panels.append(panel)

func _update_panels() -> void:
	for i in range(panels.size()):
		var panel = panels_container.get_child(i)
		panel.selected = i == selected_index

func _on_up_pressed() -> void:
	if active_piece == null: return
	active_piece.position += Vector2(0, -cell_size.y)

func _on_left_pressed() -> void:
	if active_piece == null: 
		_move_selection(-1)
	else:
		active_piece.position += Vector2(-cell_size.x, 0)

func _on_right_pressed() -> void:
	if active_piece == null: 
		_move_selection(1)
	else:
		active_piece.position += Vector2(cell_size.x, 0)

func _on_down_pressed() -> void:
	if active_piece == null: return
	active_piece.position += Vector2(0, cell_size.y)

func _on_confirm_pressed() -> void:
	if active_piece == null:
		_set_active_piece()
	else:
		active_piece = null
		_fade_in_board()
		
	_update_controls_hint()

func _on_remove_pressed() -> void:
	if active_piece == null:
		var piece = board.get_child(selected_index)
		piece.position = Vector2.ZERO
		piece.visible = false
	else:
		active_piece.visible = false
		active_piece.position = Vector2.ZERO
		_on_confirm_pressed()

	_update_controls_hint()

func _set_active_piece() -> void:
	var piece = board.get_child(selected_index)
	active_piece = piece
	active_piece.visible = true
	_fade_out_board()

func _unset_active_piece() -> void:
	active_piece = null
	_update_controls_hint()

func _update_controls_hint() -> void:
	if active_piece != null:
		controls_hint = CONTROLS_HINT_ACTIVE_PIECE
		return

	var piece = board.get_child(selected_index)
	if piece.visible == false:
		controls_hint = CONTROLS_HINT_NEW_PIECE
	else:
		controls_hint = CONTROLS_HINT_EXISTING_PIECE

func _fade_out_board() -> void:
	for i in range(board.get_child_count()):
		var piece = board.get_child(i)
		if piece != active_piece:
			piece.modulate = Color(0, 0, 0, 0.5)

func _fade_in_board() -> void:
	for i in range(board.get_child_count()):
		var piece = board.get_child(i)
		piece.modulate = Color(1, 1, 1, 1)
