class_name SelectablePanel
extends Panel

@export var value : String = "": set = set_value
@export var selected := false: set = _set_selected

func _ready() -> void:
	_update_label()
	_update_style()

func is_empty() -> bool:
	return value.is_empty()

func set_value(new_value: String) -> void:
	value = new_value
	_update_label()

func _set_selected(new_state: bool) -> void:
	selected = new_state
	_update_style()

func _update_label() -> void:
	$Label.text = str(value)

func _update_style() -> void:
	var style_box = StyleBoxFlat.new()
	style_box.bg_color = Color(0.15, 0.15, 0.15)
	style_box.set_border_width_all(3)
	style_box.border_color = Color.WHITE if selected else Color.TRANSPARENT
	add_theme_stylebox_override("panel", style_box)
