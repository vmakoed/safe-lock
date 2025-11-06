extends Node2D

@onready var level_selector := %LevelSelector
@onready var tic_tac_toe := %TicTacToe

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_tic_tac_toe_level_button_pressed() -> void:
	level_selector.visible = false
	tic_tac_toe.visible = true

func _on_tic_tac_toe_back_button_pressed() -> void:
	tic_tac_toe.visible = false
	level_selector.visible = true
