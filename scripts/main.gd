extends Node2D

@onready var level_selector := %LevelSelector
@onready var tic_tac_toe := %TicTacToe
@onready var safe := %Safe

var current_level: Control = null

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _on_level_back_button_pressed() -> void:
	current_level.visible = false
	level_selector.visible = true

func _on_tic_tac_toe_level_button_pressed() -> void:
	_switch_level(tic_tac_toe)

func _on_safe_level_button_pressed() -> void:
	_switch_level(safe)

func _switch_level(level) -> void:
	current_level = level
	level_selector.visible = false
	level.visible = true
