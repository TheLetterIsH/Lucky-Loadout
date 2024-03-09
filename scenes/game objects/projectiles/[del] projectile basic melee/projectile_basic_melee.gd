extends ProjectileBase

@export var projectile_test_particles: PackedScene


func _ready():
	super._ready()
	
	self.rotate(movement_direction.angle())


func _physics_process(delta):
	super._physics_process(delta)
	
	position = position.lerp(destination_position, speed * delta)
	if (position.distance_squared_to(destination_position) <= 1):
		destroy()


func destroy():
	var particles_instance = projectile_test_particles.instantiate()
	particles_instance.position = self.global_position
	particles_instance.emitting = true
	self.add_sibling(particles_instance)
	queue_free()


func _on_body_entered(body: Node2D):
	if is_piercing:
		return
	destroy()
