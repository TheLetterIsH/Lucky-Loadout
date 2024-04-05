extends Node

@export var gold: int


func _ready():
	# TODO If save exists, set gold value else starting gold is 5
	gold = 11


func increase_gold(amount: int):
	gold += amount


func decrease_gold(amount: int):
	gold -= amount
