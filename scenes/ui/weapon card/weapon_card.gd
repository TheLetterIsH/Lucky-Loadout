extends PanelContainer
class_name WeaponCard

@export var weapon_resource: WeaponResource

@onready var weapon_name = %WeaponName
@onready var weapon_class = %WeaponClass
@onready var weapon_description = %WeaponDescription
@onready var buy_button = %BuyButton
@onready var info_container = %InfoContainer
@onready var sold_container = %SoldContainer


func _ready():
	pass


func _process(delta):
	if WeaponsManager.is_loadout_full():
		buy_button.disabled = true
	else:
		buy_button.disabled = false
	
	# If current gold is less than the cost of the weapon
	if GoldManager.gold < weapon_resource.cost:
		buy_button.disabled = true


func set_values():
	set_as_active()
	clear_data()
	
	weapon_name.modulate = weapon_resource.color
	weapon_name.append_text("[center][wave amp=10.0 freq=2.5]%s[/wave][/center]" % weapon_resource.name)
	weapon_class.append_text("[center]%s[/center]" % "Weapon Class") # To change
	weapon_description.append_text("[center]%s[/center]" % weapon_resource.description)
	buy_button.text = "Buy: " + str(weapon_resource.cost) + "G"


func set_as_active():
	info_container.visible = true
	sold_container.visible = false


func set_as_sold():
	info_container.visible = false
	sold_container.visible = true


func clear_data():
	weapon_name.clear()
	weapon_class.clear()
	weapon_description.clear()


func _on_buy_button_pressed():
	GameEvents.fire_weapon_bought(weapon_resource)
	GoldManager.decrease_gold(weapon_resource.cost)
	set_as_sold()
