# Script: WeaponsManager (Autoload)
# Job:
# - Keeps track of all the weapons in the game at all times.
# - Keeps track of the current loadout at all times in the game.

extends Node

@export var all_weapons: Array[WeaponResource]
@export var current_loadout: Array[WeaponResource]
@export var default_weapon: WeaponResource
@export var current_loadout_paths: Array[String]


func _ready():
	# Connecting signals
	GameEvents.save_data_deleted.connect(on_save_data_deleted)
	GameEvents.weapon_bought.connect(on_weapon_bought)
	GameEvents.weapon_sold.connect(on_weapon_sold)
	
	# If save exists then get current loadout from save 
	# else have a single default weapon -- weapon wooden stick
	if (SaveSystem.has("current_loadout_paths")):
		current_loadout_paths.assign(SaveSystem.get_var("current_loadout_paths"))
		set_loadout_from_save()
	else:
		current_loadout.assign([default_weapon])
		save_loadout()


func _process(delta):
	pass


func save_loadout():
	current_loadout_paths.clear()
	
	for weapon in current_loadout:
		current_loadout_paths.append(weapon.resource_path)
	
	SaveSystem.set_var("current_loadout_paths", current_loadout_paths)
	SaveSystem.save()


func set_loadout_from_save():
	current_loadout.clear()
	
	for path in current_loadout_paths:
		var resource = load(path)
		current_loadout.append(resource)


func on_weapon_bought(weapon_resource):
	current_loadout.append(weapon_resource)
	save_loadout()


func on_weapon_sold(weapon_index, weapon_resource):
	current_loadout.remove_at(weapon_index)
	save_loadout()


func on_save_data_deleted():
	current_loadout.assign([default_weapon])
	save_loadout()


func get_loadout():
	return current_loadout


func get_random_weapon_from_loadout():
	if current_loadout == null or current_loadout.size() == 0:
		return
	
	var current_weapon = current_loadout.pick_random() as WeaponResource
	return current_weapon


func get_random_weapon_from_all_weapons():
	return all_weapons.pick_random() as WeaponResource


func is_loadout_full():
	if current_loadout.size() >= 6:
		return true
	
	return false
