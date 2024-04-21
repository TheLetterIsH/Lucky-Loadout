extends Control

var shop_scene_path = "res://scenes/shop/shop.tscn"

@onready var play_button = %PlayButton


func _ready():
	GameEvents.save_data_deleted.connect(on_save_data_deleted)


func _on_play_button_pressed():
	# TODO Add on play button pressed event
	SceneManager.change_scene(shop_scene_path,
		{ "speed" : 5.0,
		  "color" : Color("#927cdf"),
		  "pattern_enter" : "circle",
		  "pattern_leave" : "squares",
		})


func _on_reset_button_pressed():
	GameEvents.fire_save_data_deleted()


func on_save_data_deleted():
	SaveSystem.delete_all()
	SaveSystem.save()
