extends Control

@export var cell_size: Vector2i = Vector2i(128, 128)
@export var grid_size: Vector2i = Vector2i(5, 4)

func _draw() -> void:
	var cs := Vector2(cell_size)
	var W := grid_size.x * cs.x
	var H := grid_size.y * cs.y
	var col := Color(1,1,1,0.25)

	# verticals
	for x in range(grid_size.x + 1):
		var px := x * cs.x + 0.5
		draw_line(Vector2(px, 0), Vector2(px, H), col, 1.0, true)

	# horizontals
	for y in range(grid_size.y + 1):
		var py := y * cs.y + 0.5
		draw_line(Vector2(0, py), Vector2(W, py), col, 1.0, true)
