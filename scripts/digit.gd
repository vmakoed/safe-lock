class_name Digit
extends Panel

@export var value := 0: set = _set_value
@export var selected := false: set = _set_selected

func _ready():
	_update_display()
	_update_style()

func increment():
	value += 1

func decrement():
	value -= 1

func _set_value(new_value: int):
	value = wrapi(new_value, 0, 10)
	_update_display()

func _set_selected(new_state: bool):
	selected = new_state
	_update_style()

func _update_display():
	$Label.text = str(value)

func _update_style():
	var style_box = StyleBoxFlat.new()
	style_box.bg_color = Color(0.15, 0.15, 0.15)
	style_box.set_border_width_all(3)
	style_box.border_color = Color.WHITE if selected else Color.TRANSPARENT
	add_theme_stylebox_override("panel", style_box)
