extends Node

signal primary_action_used
signal weapon_switched


func fire_primary_action_used():
	primary_action_used.emit()


func fire_weapon_switched():
	weapon_switched.emit()
