# Script: Player
# Job:
# - Handles the movement of the player character in the game.

extends CharacterBody2D
class_name Player

@export_category("Player")
@export_group("Movement")
@export var speed = 250
@export var friction = 0.15
@export var acceleration = 0.15

var deadzone = 0.2

@onready var pivot = $Pivot


func _ready():
	pass


func _process(delta):
	player_aim()


func _physics_process(delta):
	player_movement()


func player_movement():
	var movement_direction = get_movement_direction_normalized()
	if movement_direction.length() > 0:
		velocity = velocity.lerp(movement_direction * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()


func player_aim():
	pivot.rotation = get_aim_direction_normalized().angle() # Aim indicator towards mouse position


func get_movement_direction_normalized():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return direction.normalized()


func get_aim_direction_normalized():
	var global_mouse_position = get_global_mouse_position()
	var aim_direction: Vector2 = self.global_position.direction_to(global_mouse_position)
	#aim_direction = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	
	return aim_direction.normalized()
