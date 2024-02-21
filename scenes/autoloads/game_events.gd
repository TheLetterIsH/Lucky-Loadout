extends Node

signal primary_action_pressed
signal weapon_switched


func fire_primary_action_pressed():
	primary_action_pressed.emit()


func fire_weapon_switched():
	weapon_switched.emit()
