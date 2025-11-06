extends Control

const BUTTONS_AMOUNT = 4
const INITIAL_DIGITS = [0, 0, 0, 0]
const MIN_DIGIT = 0
const MAX_DIGIT = 9

@onready var safe_buttons_container := %SafeButtonsContainer

func _ready() -> void:
	for i in range(BUTTONS_AMOUNT):
		var digit_container = safe_buttons_container.get_node("DigitContainer" + str(i))
		var label = digit_container.get_node("Panel/Label")
		var minus_button = digit_container.get_node("MinusButton")
		var plus_button = digit_container.get_node("PlusButton")

		label.text = str(INITIAL_DIGITS[i])
		minus_button.pressed.connect(_on_digit_changed.bind(i, -1))
		plus_button.pressed.connect(_on_digit_changed.bind(i, 1))


func _on_digit_changed(digit_index: int, delta: int) -> void:
	var digit_container = safe_buttons_container.get_node("DigitContainer" + str(digit_index))
	var label = digit_container.get_node("Panel/Label")

	var current_value = int(label.text)

	var new_value = current_value + delta
	if new_value > MAX_DIGIT:
		new_value = MIN_DIGIT
	elif new_value < MIN_DIGIT:
		new_value = MAX_DIGIT

	label.text = str(new_value)

func _process(_delta: float) -> void:
	pass
