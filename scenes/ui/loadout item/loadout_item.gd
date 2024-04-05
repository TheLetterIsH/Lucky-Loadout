extends MarginContainer
class_name LoadoutItem

@export var weapon_resource: WeaponResource
@export var weapon_index: int

@onready var weapon_name = %WeaponName
@onready var remove_button = %RemoveButton


func _ready():
	weapon_name.clear()


func _process(delta):
	if WeaponsManager.current_loadout.size() == 1:
		remove_button.disabled = true
	else:
		remove_button.disabled = false


func set_values():
	weapon_name.modulate = weapon_resource.color
	weapon_name.append_text("[center][wave amp=10.0 freq=2.5]%s[/wave][/center]" % weapon_resource.name)


func _on_remove_button_pressed():
	GameEvents.fire_weapon_sold(weapon_index, weapon_resource)
