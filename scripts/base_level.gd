class_name BaseLevel
extends Control

signal back_button_pressed
signal controls_hint_updated

@export var level_title: String = ""
@export var controls_hint: String = "B: BACK": set = _set_controls_hint

func handle_input(action: String) -> void:
	match action:
		"b": _on_back_button_pressed()

func _set_controls_hint(value: String) -> void:
	controls_hint = value
	controls_hint_updated.emit()

func _on_back_button_pressed() -> void:
	back_button_pressed.emit()