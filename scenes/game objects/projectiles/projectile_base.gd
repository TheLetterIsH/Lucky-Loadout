extends Area2D
class_name ProjectileBase

@export_category("Parameters")
@export var is_piercing: bool
@export var piercing_depth: int
@export var is_chaining: bool
@export var chain_depth: int
@export var is_homing: bool
@export_range(0, 10) var homing_strength: float
@export var can_bounce: bool
@export var number_of_bounces: int
@export var can_spawn_projectiles: bool
@export var number_of_projectiles: int
@export var is_aoe: bool
@export var aoe_scene: PackedScene

var origin_position: Vector2
var destination_position: Vector2
var movement_direction: Vector2
var range: float
var speed: float
var damage: float


func _ready():
	pass


func _physics_process(delta):
	pass


func destroy():
	pass


func _on_body_entered(body):
	pass
