extends Control

signal back_button_pressed

const WIN_CELL_INDEX = 8

@onready var grid := %GridContainer
@onready var message := %Message
@onready var filled_button_resource = preload("res://resources/tic-tac-toe/filled-button.tres")

func _ready() -> void:
	for i in grid.get_child_count():
		var button: Button = grid.get_child(i)
		button.pressed.connect(_on_button_pressed.bind(i, button))

func _on_button_pressed(index, button) -> void:
	if index == WIN_CELL_INDEX:
		button.text = "O"
		message.text = "Well done!"
		_color_buttons()
		_disable_buttons()
	else:
		message.text = "Try again"

func _color_buttons() -> void:
	for i in grid.get_child_count():
		var button: Button = grid.get_child(i)
		if button.text != "":
			button.add_theme_stylebox_override("disabled", filled_button_resource)

func _disable_buttons() -> void:
	for i in grid.get_child_count():
		var button: Button = grid.get_child(i)
		button.disabled = true


func _on_back_button_pressed() -> void:
	back_button_pressed.emit()
