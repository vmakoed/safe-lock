extends Control

@onready var tetrominoes_board := %TetrominoesBoard
@onready var tetrominoes_controls := %TetrominoesControls
@onready var tetrominoes_buttons := %TetrominoesButtons

@export var cell_size: Vector2i = Vector2i(128, 128)
@export var grid_size: Vector2i = Vector2i(5, 4)

var active_piece: Control = null

func _ready() -> void:
	var up_button = tetrominoes_controls.get_node("UpButton")
	var left_button = tetrominoes_controls.get_node("LeftButton")
	var right_button = tetrominoes_controls.get_node("RightButton")
	var down_button = tetrominoes_controls.get_node("DownButton")
	var confirm_button = tetrominoes_controls.get_node("ConfirmButton")
	var delete_button = tetrominoes_controls.get_node("DeleteButton")

	up_button.pressed.connect(_on_up_button_pressed)
	left_button.pressed.connect(_on_left_button_pressed)
	right_button.pressed.connect(_on_right_button_pressed)
	down_button.pressed.connect(_on_down_button_pressed)
	confirm_button.pressed.connect(_on_confirm_button_pressed)
	delete_button.pressed.connect(_on_delete_button_pressed)

	for i in range(tetrominoes_buttons.get_child_count()):
		var button = tetrominoes_buttons.get_child(i)
		button.pressed.connect(set_active_piece.bind(i))


func _on_up_button_pressed() -> void:
	if active_piece == null: return
	active_piece.position += Vector2(0, -cell_size.y)

func _on_left_button_pressed() -> void:
	if active_piece == null: return
	active_piece.position += Vector2(-cell_size.x, 0)

func _on_right_button_pressed() -> void:
	if active_piece == null: return
	active_piece.position += Vector2(cell_size.x, 0)

func _on_down_button_pressed() -> void:
	if active_piece == null: return
	active_piece.position += Vector2(0, cell_size.y)

func _on_confirm_button_pressed() -> void:
	active_piece = null
	_enable_piece_buttons()
	_fade_in_board()

func _on_delete_button_pressed() -> void:
	if active_piece == null: return
	active_piece.visible = false
	active_piece.position = Vector2.ZERO
	_on_confirm_button_pressed()

func set_active_piece(piece_index: int) -> void:
	var piece = tetrominoes_board.get_child(piece_index)
	active_piece = piece
	active_piece.visible = true
	_disable_piece_buttons()
	_fade_out_board()

func _disable_piece_buttons() -> void:
	for i in range(tetrominoes_buttons.get_child_count()):
		var button = tetrominoes_buttons.get_child(i)
		button.disabled = true

func _enable_piece_buttons() -> void:
	for i in range(tetrominoes_buttons.get_child_count()):
		var button = tetrominoes_buttons.get_child(i)
		button.disabled = false

func _fade_out_board() -> void:
	for i in range(tetrominoes_board.get_child_count()):
		var piece = tetrominoes_board.get_child(i)
		if piece != active_piece:
			piece.modulate = Color(0, 0, 0, 0.5)

func _fade_in_board() -> void:
	for i in range(tetrominoes_board.get_child_count()):
		var piece = tetrominoes_board.get_child(i)
		piece.modulate = Color(1, 1, 1, 1)