extends BaseLevel

signal unlocked

const BUTTONS_AMOUNT = 4
const INITIAL_DIGITS = [0, 0, 0, 0]
const MIN_DIGIT = 0
const MAX_DIGIT = 9
const DIGITS_SOLUTION = [4, 6, 5, 0]

@onready var buttons_container := %ButtonsContainer
@onready var message := %SafeMessage

var current_digits = INITIAL_DIGITS.duplicate()

func _ready() -> void:
	for i in range(BUTTONS_AMOUNT):
		var digit_container = buttons_container.get_node("DigitContainer" + str(i))
		var label = digit_container.get_node("Panel/Label")
		var minus_button = digit_container.get_node("MinusButton")
		var plus_button = digit_container.get_node("PlusButton")

		label.text = str(INITIAL_DIGITS[i])
		minus_button.pressed.connect(_on_digit_changed.bind(i, -1))
		plus_button.pressed.connect(_on_digit_changed.bind(i, 1))

func _on_digit_changed(digit_index: int, delta: int) -> void:
	var digit_container = buttons_container.get_node("DigitContainer" + str(digit_index))
	var label = digit_container.get_node("Panel/Label")

	var current_value = int(label.text)

	var new_value = current_value + delta
	if new_value > MAX_DIGIT:
		new_value = MIN_DIGIT
	elif new_value < MIN_DIGIT:
		new_value = MAX_DIGIT

	current_digits[digit_index] = new_value
	label.text = str(new_value)

func _on_input_button_pressed() -> void:
	if current_digits == DIGITS_SOLUTION:
		unlocked.emit()
	else:
		message.text = "Try again"
