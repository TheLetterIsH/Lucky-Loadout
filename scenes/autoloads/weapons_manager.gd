# Script: WeaponsManager (Autoload)
# Job:
# - Keeps track of all the weapons in the game at all times.
# - Keeps track of the current loadout at all times in the game.

extends Node

@export var all_weapons: Array[WeaponResource]
@export var current_loadout: Array[WeaponResource]
@export var default_weapon: WeaponResource


func _ready():
	# Connecting signals
	GameEvents.weapon_bought.connect(on_weapon_bought)
	GameEvents.weapon_sold.connect(on_weapon_sold)
	
	# TODO If save exists then get current loadout from save 
	# else have a single default weapon -- weapon wooden stick
	current_loadout.append(default_weapon)


func _process(delta):
	pass


func on_weapon_bought(weapon_resource):
	current_loadout.append(weapon_resource)


func on_weapon_sold(weapon_index, weapon_resource):
	current_loadout.remove_at(weapon_index)


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
