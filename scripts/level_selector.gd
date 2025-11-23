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

	if levels_list.get_item_count() > 0:
		levels_list.select(0)

func handle_input(action: String) -> void:
	match action:
		"up": _move_selection(-1)
		"down": _move_selection(1)
		"a": _on_level_selection_confirmed()

func _move_selection(direction: int) -> void:
	levels_list.select(levels_list.get_selected_items()[0] + direction)

func _on_level_selection_confirmed() -> void:
	level_selection_confirmed.emit(
		level_names[
			levels_list.get_selected_items()[0]
		]
	)
