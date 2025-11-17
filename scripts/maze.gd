extends Control

const GRID_SIZE = 64

signal back_button_pressed

@onready var player := %Player
@onready var solution := %SolutionTileMap

func _on_up_button_pressed() -> void:
	_move(Vector2.UP)

func _on_left_button_pressed() -> void:
	_move(Vector2.LEFT)

func _on_right_button_pressed() -> void:
	print("pressed")
	_move(Vector2.RIGHT)

func _on_down_button_pressed() -> void:
	_move(Vector2.DOWN)

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

func _on_back_button_pressed() -> void:
	back_button_pressed.emit()
