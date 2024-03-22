extends Node

@export var act: int
@export var stage: int
@export var wave: int


func _ready():
	# TODO Load act, stage and wave if there exists a save or else give default values
	act = 1
	stage = 1
