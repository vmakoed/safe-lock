extends BaseLevel

const GRID_SIZE = 64

@onready var player := %Player
@onready var solution := %SolutionTileMap

func handle_input(action: String) -> void:
	match action:
		"up": _move(Vector2.UP)
		"left": _move(Vector2.LEFT)
		"down": _move(Vector2.DOWN)
		"right": _move(Vector2.RIGHT)
		"b": _on_back_button_pressed()

func _move(direction: Vector2) -> void:
	var position_change := direction * GRID_SIZE
	var motion = Vector2(position_change)
	var hit = player.move_and_collide(motion, true)

	if hit == null:
		player.position += position_change

func _on_exit_body_entered(body: Node2D) -> void:
	if body == player:
		solution.visible = true
		player.visible = false
