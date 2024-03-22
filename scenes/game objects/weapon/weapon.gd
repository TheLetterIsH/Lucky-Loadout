# Script: Weapon
# Job:
# - Handles the spawning of projectiles, aoes or even other entities.
# - It has a base signal called primary_action_pressed that is fired when the player presses the primary action.
# - Handles switching of weapons every 7 seconds.

extends Node2D
class_name Weapon

@export var current_weapon: WeaponResource
@export var can_use_primary_action: bool

var player: Player
var entity_container: Node2D

@onready var timer = $Timer


func _ready():
	# Connecting signals
	GameEvents.primary_action_used.connect(on_primary_action_used)
	timer.timeout.connect(on_timer_timeout)
	
	# Get variables
	player = GameManager.get_player() as Player
	entity_container = GameManager.get_entity_container()
	
	# Debug -----------
	current_weapon = preload("res://resources/weapons/00_weapon_none.tres")
	# -----------------
	#current_weapon = WeaponsManager.get_random_weapon_from_loadout+() as WeaponResource
	intialize_weapon()


func _process(delta):
	if Input.is_action_pressed("primary_action"):
		# FOR PROJECTILE
		# Check if can shoot and then shoot
		if can_use_primary_action:
			GameEvents.fire_primary_action_used()
			can_use_primary_action = false
			timer.start()
		# END


func on_primary_action_used():
	# FOR PROJECTILE
	
	# Get current position and aim direction
	var current_position: Vector2 = player.global_position
	var aim_direction: Vector2 = player.get_aim_direction_normalized()
	
	if current_weapon.projectile_is_multishot: # If current weapon is multishot
		var spread_in_radians = deg_to_rad(current_weapon.projectile_spread)
		for i in range(current_weapon.projectile_number_of_shots):
			aim_direction = player.get_aim_direction_normalized() # Get aim direction for each shot
			var random_spread_angle = randf_range(-spread_in_radians / 2, spread_in_radians / 2)
			aim_direction = aim_direction.rotated(random_spread_angle)
			calculate_parameters_and_spawn_projectile(current_position, aim_direction)
	else: # If current weapon is not multishot
		match current_weapon.projectile_mode:
			"single":
				calculate_parameters_and_spawn_projectile(current_position, aim_direction)
			"burst":
				for i in range(3):
					current_position = player.global_position # Get position for each shot
					calculate_parameters_and_spawn_projectile(current_position, aim_direction)
					await get_tree().create_timer(0.1).timeout
			_:
				calculate_parameters_and_spawn_projectile(current_position, aim_direction)
	# END


func calculate_parameters_and_spawn_projectile(current_position, aim_direction):
	# Apply accuracy variation
	var accuracy_variation_in_radians = deg_to_rad(current_weapon.projectile_accuracy_variation)
	var random_accuracy_variation = randf_range(-accuracy_variation_in_radians / 2, accuracy_variation_in_radians / 2)
	aim_direction = aim_direction.rotated(random_accuracy_variation)
	
	# Calculate the range of the projectile
	var projectile_range = current_weapon.projectile_range + randf_range(-current_weapon.projectile_range_variation, current_weapon.projectile_range_variation)
	projectile_range *= 32 # Multiply range by unit size 32
	
	# Calculate the destination of the projectile based on the range
	var projectile_destination_position = current_position + aim_direction * projectile_range
	
	# Calculare the damage to be done by the projectile
	var projectile_damage = randf_range(current_weapon.projectile_min_damage, current_weapon.projectile_max_damage)
	
	# Spawn a projectile with initial position, destination position, direction, range and speed
	var projectile_instance: ProjectileBase = current_weapon.projectile_scene.instantiate() as ProjectileBase
	projectile_instance.position = current_position
	projectile_instance.origin_position = current_position
	projectile_instance.destination_position = projectile_destination_position
	projectile_instance.movement_direction = aim_direction
	projectile_instance.range = projectile_range
	projectile_instance.speed = current_weapon.projectile_speed
	projectile_instance.damage = projectile_damage
	entity_container.add_child(projectile_instance)


func on_timer_timeout():
	# FOR PROJECTILE
	# When timer runs out of time, can shoot is set to true
	can_use_primary_action = true
	# END


func switch_weapon():
	# TODO add effects, fire signals
	var current_weapon = WeaponsManager.get_random_weapon_from_loadout()
	GameEvents.fire_weapon_switched()
	intialize_weapon()


func intialize_weapon():
	# FOR PROJECTILE
	# Set weapon's timer to be 1 / rate
	if current_weapon.projectile_rate == 0:
		return
	timer.wait_time = 1 / current_weapon.projectile_rate
	# END
