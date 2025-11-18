class_name BaseLevel
extends Control

signal back_button_pressed

@export var level_title: String = ""
@export var controls_hint: String = "B: BACK"

func handle_input(action: String) -> void:
	match action:
		"b": _on_back_button_pressed()

func _on_back_button_pressed() -> void:
	back_button_pressed.emit()