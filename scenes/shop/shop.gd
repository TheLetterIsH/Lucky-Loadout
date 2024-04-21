# Script: Shop
# Job:
# - Set up the weapon cards.
# - Set up the loadout items.
# - Set up info.

extends Control

@export var loadout_item_scene: PackedScene
@export var reroll_cost: int = 1
@export var is_shop_locked: bool

var game_scene_path = "res://scenes/game/game.tscn"

@onready var weapon_card_container = %WeaponCardContainer
@onready var loadout_main_container = %LoadoutMainContainer
@onready var loadout_items_container = %LoadoutItemsContainer
@onready var stage_value_label = %StageValueLabel
@onready var gold_value_label = %GoldValueLabel
@onready var reroll_button = %RerollButton
@onready var lock_button = %LockButton
@onready var fight_button = %FightButton


func _ready():
	# Connecting signals
	GameEvents.weapon_bought.connect(on_weapon_bought)
	GameEvents.weapon_sold.connect(on_weapon_sold)
	
	set_info()
	set_weapon_cards()
	set_loadout_items()
	#animate_weapon_cards()


func _process(delta):
	set_info()


func set_info():
	stage_value_label.clear()
	stage_value_label.append_text("[center][wave amp=10 freq=2.5]%d[/wave][/center]" % StageManager.stage)
	
	gold_value_label.clear()
	gold_value_label.append_text("[center][wave amp=10 freq=2.5]%d[/wave][/center]" % GoldManager.gold)
	
	if GoldManager.gold < reroll_cost  or is_shop_locked:
		reroll_button.disabled = true
	elif !is_shop_locked:
		reroll_button.disabled = false
	reroll_button.text = "Reroll: %dG" % reroll_cost
	
	if is_shop_locked:
		lock_button.text = "Unlock"
	else:
		lock_button.text = "Lock"


func set_weapon_cards():
	if is_shop_locked:
		return
	
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUINT)
	
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


func reroll_weapons():
	GoldManager.decrease_gold(reroll_cost)
	reroll_cost += 1
	
	set_weapon_cards()
	animate_weapon_cards()


func animate_weapon_cards():
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUINT)
	
	var weapon_cards = weapon_card_container.get_children()

	for i in range(3):
		var weapon_card = weapon_cards[i] as PanelContainer
		var y_position = weapon_card.position.y
		tween.tween_property(weapon_card, "position:y", y_position - 6, 0.125).from(y_position)
		tween.tween_property(weapon_card, "position:y", y_position + 12, 0.125).from(y_position - 6)
		tween.tween_property(weapon_card, "position:y", y_position, 0.125).from(y_position + 12)


func animate_loadout():
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUINT)
	var y_position = loadout_main_container.position.y
	tween.tween_property(loadout_main_container, "position:y", y_position - 6, 0.125).from(y_position)
	tween.tween_property(loadout_main_container, "position:y", y_position + 12, 0.125).from(y_position - 6)
	tween.tween_property(loadout_main_container, "position:y", y_position, 0.125).from(y_position + 12)


func on_weapon_bought(weapon_resource):
	set_loadout_items()
	animate_loadout()


func on_weapon_sold(weapon_index, weapon_resource):
	set_loadout_items()
	animate_loadout()


func _on_reroll_button_pressed():
	reroll_weapons()


func _on_lock_button_pressed():
	is_shop_locked = !is_shop_locked


func _on_fight_button_pressed():
	SceneManager.change_scene(game_scene_path,
		{ "color" : Color("#f4f4f4"),
		  "pattern_enter" : "circle",
		  "pattern_leave" : "squares",
		})
