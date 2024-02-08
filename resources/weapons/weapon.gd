extends Resource
class_name Weapon

@export_group("Information")
@export var id: int
@export var name: String
@export var description: String

@export_group("Parameters")
@export var rate: float
@export var accuracy: float
@export var min_range: float
@export var max_range: float
@export var speed: float
@export var damage: float
