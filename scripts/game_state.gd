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

func get_tic_tac_toe_completed() -> bool:
	return save_game.tic_tac_toe_completed

func set_tic_tac_toe_completed(completed: bool) -> void:
	save_game.tic_tac_toe_completed = completed

func get_maze_started() -> bool:
	return save_game.maze_started

func set_maze_started(started: bool) -> void:
	save_game.maze_started = started

func get_maze_player_position() -> Vector2:
	return save_game.maze_player_position

func set_maze_player_position(position: Vector2) -> void:
	save_game.maze_player_position = position

func get_maze_completed() -> bool:
	return save_game.maze_completed

func set_maze_completed(completed: bool) -> void:
	save_game.maze_completed = completed

func get_tetrominoes_pieces() -> Array:
	return save_game.tetrominoes_pieces

func set_tetrominoes_pieces(pieces: Array) -> void:
	save_game.tetrominoes_pieces = pieces

func _load_from_disk() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		save_game = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		save_game = SaveGame.new()
