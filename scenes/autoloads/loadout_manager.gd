# Script: LoadoutManager (Autoload)
# Job:
# - Keeps track of the current loadout at all times in the game.
# - Possibly keeps track of all the weapons in the game at all times.

extends Node

@export var all_weapons: Array[WeaponResource]
@export var current_loadout: Array[WeaponResource]


func _ready():
	pass


func _process(delta):
	if current_loadout.size() <= 6:
		pass


func get_random_weapon_from_loadout():
	if current_loadout == null or current_loadout.size() == 0:
		return
	
	var current_weapon = current_loadout.pick_random() as WeaponResource
	return current_weapon
