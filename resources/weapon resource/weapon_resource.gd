extends Resource
class_name WeaponResource

@export_category("Weapon Data")
@export var id: int
@export var identifier: String
@export var name: String
@export_enum("projectile", "aoe", "entity") var type: String
@export_multiline var description: String
@export var cost: int
@export var color: Color

@export_group("Projectile")
@export var projectile_scene: PackedScene
@export var projectile_rate: float
@export_range(0, 12) var projectile_accuracy_variation: float
@export var projectile_range: float
@export_range(0, 2) var projectile_range_variation: float
@export var projectile_speed: float
@export var projectile_min_damage: float
@export var projectile_max_damage: float
@export_enum("single", "burst") var projectile_mode: String
@export var projectile_is_multishot: bool
@export var projectile_number_of_shots: int
@export_range(0, 360) var projectile_spread: float

@export_group("AOE")
@export var aoe_scene: PackedScene
@export var aoe_range: float
