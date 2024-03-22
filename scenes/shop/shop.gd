# Script: Shop
# Job:
# - Set up the weapon cards.
# - Set up the loadout items.
# - Set up info.

extends Control

@export var loadout_item_scene: PackedScene

@onready var weapon_card_container = %WeaponCardContainer
@onready var loadout_items_container = %LoadoutItemsContainer
@onready var stage_label = %StageLabel
@onready var gold_label = %GoldLabel
# To be animated elements
@onready var menu_bar_container = %MenuBarContainer
@onready var shop_title_container = %ShopTitleContainer
@onready var loadout_title_container = %LoadoutTitleContainer


func _ready():
	# Connecting signals
	GameEvents.weapon_bought.connect(on_weapon_bought)
	GameEvents.weapon_sold.connect(on_weapon_sold)
	
	set_info()
	set_weapon_cards()
	set_loadout_items()
	#animate_elements()


func _process(delta):
	pass


func set_info():
	stage_label.clear()
	stage_label.append_text("[center][wave amp=10 freq=2.5]Stage\n[font_size=32]%d[/font_size][/wave][/center]" % StageManager.stage)


func set_weapon_cards():
	var weapon_cards = weapon_card_container.get_children() as Array[WeaponCard]
	for weapon_card in weapon_cards:
		var random_weapon = WeaponsManager.get_random_weapon_from_all_weapons() as WeaponResource
		weapon_card.weapon_resource = random_weapon
		weapon_card.set_values()


func set_loadout_items():
	# Delete already existing items
	for loadout_item in loadout_items_container.get_children():
		loadout_item.queue_free()
	
	var current_loadout = WeaponsManager.get_loadout()
	var loadout_items = loadout_items_container
	
	for i in range(current_loadout.size()):
		var weapon = current_loadout[i]
		var loadout_item_instance = loadout_item_scene.instantiate()
		loadout_items.add_child(loadout_item_instance)
		
		loadout_item_instance.weapon_resource = weapon
		loadout_item_instance.weapon_index = i
		loadout_item_instance.set_values()


func animate_elements():
	var generic_tween = create_tween()
	generic_tween.set_parallel(true)
	generic_tween.set_trans(10)
	generic_tween.set_ease(Tween.EASE_IN_OUT)
	generic_tween.tween_property(shop_title_container, "position", Vector2(0, 0), 0.35).from(Vector2(0, - 200))
	generic_tween.tween_property(loadout_title_container, "position", Vector2(0, 0), 0.35).from(Vector2(0, - 200))
	generic_tween.tween_property(menu_bar_container, "position", Vector2(0, 407), 0.35).from(Vector2(0, 600))
	
	var weapon_card_tween = create_tween()
	weapon_card_tween.set_parallel(false)
	weapon_card_tween.set_trans(10)
	weapon_card_tween.set_ease(Tween.EASE_IN_OUT)
	
	var weapon_cards = weapon_card_container.get_children() as Array[WeaponCard]
	for weapon_card in weapon_cards:
		weapon_card_tween.tween_property(weapon_card, "position", Vector2(0, 0), 0.35).from(Vector2(0, - 200))


func on_weapon_bought(weapon_resource):
	set_loadout_items()


func on_weapon_sold(weapon_index, weapon_resource):
	set_loadout_items()
