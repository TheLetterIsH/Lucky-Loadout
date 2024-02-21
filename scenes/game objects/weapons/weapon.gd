# Script: Weapon
# Job:
# - Handles the spawning of projectiles, aoes or even other entities.
# - It has a base signal called primary_action_pressed that is fired when the player presses the primary action.
# - Handles switching of weapons every 7 seconds.

extends Node2D
class_name Weapon

@export var current_weapon: WeaponResource
@export var can_use_primary_action: bool

var last_time_recorded: int

@onready var timer = $Timer


func _ready():
	print("ready")
	# Connecting signals
	GameEvents.primary_action_pressed.connect(on_primary_action_pressed)
	timer.timeout.connect(on_timer_timeout)
	# Debug -----------
	current_weapon = preload("res://resources/weapons/weapon_none.tres")
	# -----------------
	#current_weapon = LoadoutManager.get_random_weapon_from_loadout() as WeaponResource
	intialize_weapon()


func _process(delta):
	if Input.is_action_pressed("primary_action"):
		GameEvents.fire_primary_action_pressed()


func on_primary_action_pressed():
	# FOR PROJECTILE
	# Check if can shoot and then shoot
	if can_use_primary_action:
		can_use_primary_action = false
		timer.start()
		
		# Calculate the shoot direction
		var mouse_current_position: Vector2 = get_global_mouse_position()
		var weapon_current_position: Vector2 = self.global_position
		var shoot_direction: Vector2 = weapon_current_position.direction_to(mouse_current_position)
		
		# Apply accuracy variation
		var accuracy_variation_radians = deg_to_rad(current_weapon.projectile_accuracy_variation)
		var random_accuracy_variation = randf_range(-accuracy_variation_radians, accuracy_variation_radians)
		shoot_direction = shoot_direction.rotated(random_accuracy_variation)
		
		# Calculate the range of the projectile
		var projectile_range = current_weapon.projectile_range + randf_range(-current_weapon.projectile_range_variation, current_weapon.projectile_range_variation)
		
		# Spawn a projectile with it's: origin position, direction, and a range
		spawn_projectile(weapon_current_position, shoot_direction, projectile_range, current_weapon.projectile_speed)
	# END


func spawn_projectile(position: Vector2, direction: Vector2, range: float, speed: float):
	pass


func on_timer_timeout():
	# FOR PROJECTILE
	# When timer runs out of time, can shoot is set to true
	can_use_primary_action = true
	# END


func switch_weapon():
	# TODO add effects, fire signals
	GameEvents.fire_weapon_switched()
	var current_weapon = LoadoutManager.get_random_weapon_from_loadout()


func intialize_weapon():
	# FOR PROJECTILE
	# Set weapon's timer to be 1 / rate
	if current_weapon.projectile_rate == 0:
		return
	timer.wait_time = 1 / current_weapon.projectile_rate
	print(timer.wait_time)
	# END
