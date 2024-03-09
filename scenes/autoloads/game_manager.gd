# Script: GameManager (Autoload)
# Job:
# - Handles the overal game logic.
# - Also handles the scene changing.
# - Provides functionality to get game objects / containers.

extends Node

var debug_mode: bool = true # When true, allows for various debug functionality. Set to false in actual game.


func _process(delta):
	if debug_mode and Input.is_action_just_pressed("debug_exit_game"):
		get_tree().quit()


func get_player():
	print_rich("getting [color=green]player[/color] from scene: [color=orange]" + get_tree().current_scene.to_string() + "[/color]")
	return get_tree().get_first_node_in_group("player")


func get_entity_container():
	print_rich("getting [color=green]entity container[/color] from scene: [color=orange]" + get_tree().current_scene.to_string() + "[/color]")
	return get_tree().get_first_node_in_group("entity_container")
