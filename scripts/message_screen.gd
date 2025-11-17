class_name MessageScreen
extends BaseLevel

signal confirm_pressed

@export_multiline var message_text: String = "Message text"

@onready var label = %Label

func _ready() -> void:
	label.text = message_text
	controls_hint = "A: CONFIRM"
	button_mapping = {
		"a": "confirm"
	}

func handle_input(action: String) -> void:
	match action:
		"confirm": _on_confirm_pressed()

func _on_confirm_pressed ()-> void:
	confirm_pressed.emit()
