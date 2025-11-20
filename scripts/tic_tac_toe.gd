extends BaseLevel

const INITIAL_SELECTED_INDEX = 0
const WIN_CELL_INDEX = 8

@onready var grid : GridContainer= %GridContainer
@onready var message : Label = %Message
@onready var filled_button_resource = preload("res://resources/tic-tac-toe/filled-button.tres")

var selected_index := INITIAL_SELECTED_INDEX: set = _set_selected_index
var panels : Array[SelectablePanel] = []
var puzzle_won := false

func _ready() -> void:
	_load_panels()
	_update_panels()

func handle_input(action: String) -> void:
	match action:
		"up": _move_vertical(-1)
		"left": _move_horizontal(-1)
		"down": _move_vertical(1)
		"right": _move_horizontal(1)
		"a": _on_confirm_button_pressed()
		"b": _on_back_button_pressed()

func _set_selected_index(digit_index: int) -> void:
	selected_index = digit_index
	_update_panels()

func _load_panels() -> void:
	for i in grid.get_child_count():
		var panel: SelectablePanel = grid.get_child(i)
		panels.append(panel)

func _update_panels() -> void:
	for i in range(panels.size()):
		var panel = grid.get_child(i)
		panel.selected = i == selected_index

func _move_vertical(delta: int) -> void:
	_move_selection(0, delta)

func _move_horizontal(delta: int) -> void:
	_move_selection(delta, 0)

func _move_selection(dx: int, dy: int) -> void:
	var cols := grid.columns
	var rows := int(ceil(float(grid.get_child_count()) / cols))

	var row := selected_index / cols
	var col := selected_index % cols

	# Horizontal movement
	if dx != 0:
		col = wrapi(col + dx, 0, cols)

	# Vertical movement
	if dy != 0:
		row = wrapi(row + dy, 0, rows)

	selected_index = row * cols + col

func _on_confirm_button_pressed() -> void:
	if puzzle_won: return
	if selected_index == WIN_CELL_INDEX:
		_complete_puzzle()
	else:
		message.text = "TRY AGAIN"


func _complete_puzzle() -> void:
	var panel: SelectablePanel = grid.get_child(WIN_CELL_INDEX)
	panel.value = "O"
	puzzle_won = true
	message.text = "WELL DONE!"
	_color_cells()

func _color_cells() -> void:
	for i in grid.get_child_count():
		var panel: SelectablePanel = grid.get_child(i)
		if panel.is_empty(): continue

		var style_box = StyleBoxFlat.new()
		style_box.bg_color = Color(0.15, 0.15, 0.15)
		style_box.set_border_width_all(3)
		style_box.bg_color = Color(1, 1, 1, 0.5)
		panel.add_theme_stylebox_override("panel", style_box)
