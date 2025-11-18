extends Control

@onready var intro_screen := %IntroScreen
@onready var win_screen := %WinScreen
@onready var level_selector := %LevelSelector
@onready var tic_tac_toe := %TicTacToe
@onready var tetrominoes := %Tetrominoes
@onready var safe := %Safe
@onready var maze := %Maze

@export var win_link: String = ""

var current_level: Control = null

func _on_level_back_button_pressed() -> void:
	current_level.visible = false
	level_selector.visible = true

func _on_tic_tac_toe_level_button_pressed() -> void:
	_switch_level(tic_tac_toe)

func _on_safe_level_button_pressed() -> void:
	_switch_level(safe)

func _on_maze_level_button_pressed() -> void:
	_switch_level(maze)

func _on_tetrominoes_level_button_pressed() -> void:
	_switch_level(tetrominoes)

func _switch_level(level) -> void:
	current_level = level
	level_selector.visible = false
	level.visible = true

func _on_start_button_pressed() -> void:
	intro_screen.visible = false
	level_selector.visible = true

func _on_win_button_pressed() -> void:
	OS.shell_open(win_link)

func _on_safe_unlocked() -> void:
	safe.visible = false
	win_screen.visible = true
