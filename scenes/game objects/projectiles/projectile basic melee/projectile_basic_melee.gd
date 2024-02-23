extends ProjectileBase


func _ready():
	super._ready()
	
	self.rotate(movement_direction.angle())


func _physics_process(delta):
	super._physics_process(delta)
	
	global_position = global_position.lerp(destination_position, speed * delta)
	if (global_position.distance_squared_to(destination_position) <= 1):
		queue_free()
