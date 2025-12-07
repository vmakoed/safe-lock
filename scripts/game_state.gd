extends Node

const SAVE_PATH := "user://save.tres"
var save_game: SaveGame

func _ready() -> void:
	_load_from_disk()

func save_to_disk() -> void:
	ResourceSaver.save(save_game, SAVE_PATH)

func get_last_selected_level() -> int:
	return save_game.level_selector_last_selected_index

func set_last_selected_level(index: int) -> void:
	save_game.level_selector_last_selected_index = index

func get_safe_digit_values() -> Array[int]:
	return save_game.safe_digit_values

func set_safe_digit_values(digit_values: Array[int]) -> void:
	save_game.safe_digit_values = digit_values

func _load_from_disk() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		save_game = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		save_game = SaveGame.new()
