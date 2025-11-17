class_name BaseLevel
extends Control

@export var level_title: String = ""
@export var controls_hint: String = ""
@export var button_mapping := {}

func handle_input(action: String) -> void:
    # Override in child scenes
    pass
