class_name SaveGame
extends Resource

@export var level_selector_last_selected_index := 0
@export var safe_digit_values : Array[int] = [0, 0, 0, 0]
@export var tic_tac_toe_completed := false

@export var maze_started := false
@export var maze_player_position := Vector2.ZERO
@export var maze_completed := false

@export var tetrominoes_pieces : Array = [
	{"visible": false, "position": Vector2.ZERO},
	{"visible": false, "position": Vector2.ZERO},
	{"visible": false, "position": Vector2.ZERO},
	{"visible": false, "position": Vector2.ZERO},
	{"visible": false, "position": Vector2.ZERO}
]
