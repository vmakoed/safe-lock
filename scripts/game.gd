extends Control

const PUZZLES = {
	"Safe": "res://scenes/safe.tscn",
	"TicTacToe": "res://scenes/tic_tac_toe.tscn",
	"Maze": "res://scenes/maze.tscn",
	"Tetrominoes": "res://scenes/tetrominoes.tscn"
}

@export var intro_level_title: String
@export_multiline var intro_level_text: String
@export var win_level_title: String
@export_multiline var win_level_text: String

@onready var display_panel: Panel = %DisplayPanel
@onready var title_label: Label = %TitleLabel
@onready var controls_label: Label = %ControlsLabel

var current_level: BaseLevel
var button_mapping: Dictionary = {}

func _ready() -> void:
	var level = _prepare_message_screen(intro_level_title, intro_level_text)
	level.confirm_pressed.connect(_on_intro_confirmed)
	_switch_level(level)

func _prepare_message_screen(title: String, text: String) -> BaseLevel:
	var scene = load("res://scenes/message_screen.tscn")
	var level = scene.instantiate() as MessageScreen
	level.level_title = title
	level.message_text = text

	return level

func _switch_level(level: BaseLevel) -> void:
	GameState.save_to_disk()
	_unload_current_level()
	_load_level(level)

func _unload_current_level() -> void:
	if current_level:
		current_level.queue_free()

func _load_level(level: BaseLevel) -> void:
	current_level = level
	display_panel.add_child(current_level)

	if current_level.has_signal("game_won"):
		current_level.game_won.connect(_on_game_won)

	title_label.text = current_level.level_title
	current_level.controls_hint_updated.connect(_update_controls_hint)
	_update_controls_hint()

func _update_controls_hint() -> void:
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

func _on_game_won() -> void:
	var level = _prepare_message_screen(win_level_title, win_level_text)
	_switch_level(level)
