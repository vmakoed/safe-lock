extends Control

signal button_pressed

@export_multiline var message_text: String = "Message text"
@export var button_text: String = "Button text"

var button_visible : bool = true: set = _set_button_visible

@onready var label = %Label
@onready var button = %Button

func _ready() -> void:
	label.text = message_text
	button.text = button_text

func _set_button_visible(value: bool) -> void:
	button.visible = value

func _on_button_pressed() -> void:
	button_pressed.emit()
