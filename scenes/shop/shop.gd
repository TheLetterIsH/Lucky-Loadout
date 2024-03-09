extends Control

@onready var weapon_card_container = %WeaponCardContainer


func _ready():
	set_weapon_cards()


func _process(delta):
	pass


func set_weapon_cards():
	var weapon_cards = weapon_card_container.get_children() as Array[WeaponCard]
	
	for weapon_card in weapon_cards:
		var random_weapon = WeaponsManager.get_random_weapon_from_all_weapons() as WeaponResource
		weapon_card.weapon_resource = random_weapon
		weapon_card.set_values()
