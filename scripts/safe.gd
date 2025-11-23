extends BaseLevel

signal game_won

const INITIAL_SELECTED_INDEX = 0

@export var digit_values: Array[Dictionary] = [
	{
		"initial": 0,
		"solution": 4,
	},
	{
		"initial": 0,
		"solution": 6
	},
	{
		"initial": 0,
		"solution": 5
	},
	{
		"initial": 0,
		"solution": 0
	}
]

@onready var digits_container := %DigitsContainer
@onready var message := %Message

var selected_index := INITIAL_SELECTED_INDEX: set = _set_selected_index
var digits : Array[Digit] = []

func _ready() -> void:
	_load_digits()
	_update_digits()

func handle_input(action: String) -> void:
	match action:
		"up": _increment_digit()
		"left": _move_selection(-1)
		"down": _decrement_digit()
		"right": _move_selection(1)
		"a": _on_confirm_pressed()
		"b": _on_back_button_pressed()

func _increment_digit() -> void:
	digits[selected_index].increment()

func _decrement_digit() -> void:
	digits[selected_index].decrement()

func _move_selection(direction: int) -> void:
	selected_index = wrapi(selected_index + direction, 0, digits.size())

func _set_selected_index(digit_index: int) -> void:
	selected_index = digit_index
	_update_digits()

func _load_digits() -> void:
	for i in range(digit_values.size()):
		var scene = load("res://scenes/digit.tscn")
		var digit = scene.instantiate() as Digit
		digits.append(digit)
		digits_container.add_child(digit)
		digit.value = digit_values[i]["initial"]

func _update_digits() -> void:
	for i in range(digits.size()):
		var digit = digits_container.get_child(i)
		digit.selected = i == selected_index

func _on_confirm_pressed() -> void:
	for i in range(digits.size()):
		if digits[i].value != digit_values[i]["solution"]:
			message.text = "INCORRECT CODE"
			return

	message.text = "UNLOCKED"
	game_won.emit()
