# Script: GameEvents (Autoload)
# Job:
# - Fires Global level Game Event signals.
# - Acts as a Signal Bus.

extends Node

signal save_data_deleted
signal primary_action_used
signal weapon_switched
signal weapon_bought
signal weapon_sold


func fire_save_data_deleted():
	save_data_deleted.emit()


func fire_primary_action_used():
	primary_action_used.emit()


func fire_weapon_switched():
	weapon_switched.emit()


func fire_weapon_bought(weapon_resource: WeaponResource):
	weapon_bought.emit(weapon_resource)


func fire_weapon_sold(weapon_index: int, weapon_resource: WeaponResource):
	weapon_sold.emit(weapon_index, weapon_resource)
