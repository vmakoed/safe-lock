extends Control

signal safe_level_button_pressed
signal tic_tac_toe_level_button_pressed
signal maze_level_button_pressed
signal tetrominoes_level_button_pressed

func _on_safe_level_button_pressed() -> void:
	safe_level_button_pressed.emit()

func _on_tic_tac_toe_level_button_pressed() -> void:
	tic_tac_toe_level_button_pressed.emit()

func _on_maze_level_button_pressed() -> void:
	maze_level_button_pressed.emit()

func _on_tetrominoes_button_pressed() -> void:
	tetrominoes_level_button_pressed.emit()