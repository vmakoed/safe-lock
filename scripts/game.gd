extends Control

@export var intro_level_title: String
@export_multiline var intro_level_text: String

@onready var display_panel: Panel = %DisplayPanel
@onready var title_label: Label = %TitleLabel
@onready var controls_label: Label = %ControlsLabel

var current_level: BaseLevel
var button_mapping: Dictionary = {}

func _ready() -> void:
	_unload_current_level()
	var level = _prepare_intro_level()
	_load_level(level)

func _switch_level(path: String) -> void:
	_unload_current_level()
	var scene := load(path) as PackedScene
	var level = scene.instantiate() as BaseLevel
	_load_level(level)

func _prepare_intro_level() -> BaseLevel:
	var scene = load("res://scenes/message_screen.tscn")
	var level = scene.instantiate() as MessageScreen
	level.level_title = intro_level_title
	level.message_text = intro_level_text
	level.confirm_pressed.connect(_on_intro_confirmed)

	return level

func _on_intro_confirmed() -> void:
	print("intro confirmed")
	# _switch_level.bind("res://scenes/level_selector.tscn")

func _unload_current_level() -> void:
	if current_level:
		current_level.queue_free()

func _load_level(level: BaseLevel) -> void:
	current_level = level
	display_panel.add_child(current_level)

	title_label.text = current_level.level_title
	controls_label.text = current_level.controls_hint
	button_mapping = current_level.button_mapping

func _send_action(action: String) -> void:
	if current_level == null: return
	
	current_level.handle_input(action)

func _on_button_pressed(action: String)	-> void:
	if button_mapping.get(action) == null: return
	
	_send_action(button_mapping.get(action))
