extends Node2D
class_name ProjectileBase

@export var destination_position: Vector2
@export var movement_direction: Vector2
@export var speed: float


func _ready():
	print_rich("[color=lightgreen]instantiated projectile![/color]")


func _physics_process(delta):
	pass
