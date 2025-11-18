extends Control

const PUZZLES = {
	"Safe": "res://scenes/safe.tscn",
	"TicTacToe": "res://scenes/tic_tac_toe.tscn",
	"Maze": "res://scenes/maze.tscn",
	"Tetrominoes": "res://scenes/tetrominoes.tscn"
}

@export var intro_level_title: String
@export_multiline var intro_level_text: String

@onready var display_panel: Panel = %DisplayPanel
@onready var title_label: Label = %TitleLabel
@onready var controls_label: Label = %ControlsLabel

var current_level: BaseLevel
var button_mapping: Dictionary = {}

func _ready() -> void:
	var level = _prepare_intro_level()
	_switch_level(level)

func _prepare_intro_level() -> BaseLevel:
	var scene = load("res://scenes/message_screen.tscn")
	var level = scene.instantiate() as MessageScreen
	level.level_title = intro_level_title
	level.message_text = intro_level_text
	level.confirm_pressed.connect(_on_intro_confirmed)

	return level

func _switch_level(level: BaseLevel) -> void:
	_unload_current_level()
	_load_level(level)

func _unload_current_level() -> void:
	if current_level:
		current_level.queue_free()

func _load_level(level: BaseLevel) -> void:
	current_level = level
	display_panel.add_child(current_level)

	title_label.text = current_level.level_title
	controls_label.text = current_level.controls_hint

func _instantiatie_level(path: String) -> BaseLevel:
	var scene := load(path) as PackedScene
	return scene.instantiate() as BaseLevel

func _load_puzzle_selector() -> void:
	var scene = load("res://scenes/level_selector.tscn")
	var level = scene.instantiate() as LevelSelector
	level.level_names = PackedStringArray(PUZZLES.keys())	
	level.level_selection_confirmed.connect(_on_puzzle_selection_confirmed)
	_switch_level(level)

func _send_action(action: String) -> void:
	if current_level == null: return
	
	current_level.handle_input(action)

func _on_button_pressed(action: String)	-> void:	
	_send_action(action)
	
func _on_intro_confirmed() -> void:
	_load_puzzle_selector()

func _on_puzzle_selection_confirmed(level_name: String) -> void:
	var level = _instantiatie_level(PUZZLES[level_name])
	level.back_button_pressed.connect(_load_puzzle_selector) # TODO: find a way to ensure all puzzles have this signal
	_switch_level(level)
