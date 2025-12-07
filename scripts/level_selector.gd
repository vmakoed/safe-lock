class_name LevelSelector
extends BaseLevel

signal level_selection_confirmed

@export var level_names: PackedStringArray

@onready var levels_list: ItemList = %LevelsList

func _ready() -> void:
	level_title = "SELECT LEVEL"
	controls_hint = "▲▼: SELECT / A: CONFIRM"
	
	for i in level_names.size():
		levels_list.add_item(level_names[i])

	_select_initial_level()

func handle_input(action: String) -> void:
	match action:
		"up": _move_selection(-1)
		"down": _move_selection(1)
		"a": _on_level_selection_confirmed()

func _select_initial_level() -> void:
	if levels_list.get_item_count() < 0:
		return

	var last_selected_level = GameState.get_last_selected_level()
	if last_selected_level < 0 || last_selected_level > level_names.size() - 1:
		levels_list.select(0)
		return
	
	levels_list.select(last_selected_level)

func _move_selection(direction: int) -> void:
	levels_list.select(levels_list.get_selected_items()[0] + direction)

func _update_game_state(selected_level: int) -> void:
	GameState.set_last_selected_level(selected_level)

func _on_level_selection_confirmed() -> void:
	var selected_level = levels_list.get_selected_items()[0]
	_update_game_state(selected_level)
	level_selection_confirmed.emit(level_names[selected_level])
