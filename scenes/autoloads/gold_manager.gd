extends Node

@export var gold: int


func _ready():
	# Connecting signals
	GameEvents.save_data_deleted.connect(on_save_data_deleted)
	
	# If save exists, set gold value else starting gold is 5
	if (SaveSystem.has("gold")):
		gold = SaveSystem.get_var("gold")
	else:
		gold = 5
		save_gold()


func save_gold():
	SaveSystem.set_var("gold", gold)
	SaveSystem.save()


func increase_gold(amount: int):
	gold += amount
	save_gold()


func decrease_gold(amount: int):
	gold -= amount
	save_gold()


func on_save_data_deleted():
	gold = 5
	save_gold()
