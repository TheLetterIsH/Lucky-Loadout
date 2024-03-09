extends PanelContainer
class_name WeaponCard

@export var weapon_resource: WeaponResource

var is_locked: bool = false

@onready var weapon_name = %WeaponName
@onready var weapon_class = %WeaponClass
@onready var weapon_description = %WeaponDescription
@onready var buy_button = %BuyButton


func _ready():
	weapon_name.clear()
	weapon_class.clear()
	weapon_description.clear()


func set_values():
	weapon_name.append_text("[center][wave amp=10.0 freq=2.5]%s[/wave][/center]" % weapon_resource.name)
	weapon_class.append_text("[center]%s[/center]" % "Weapon Class") # To change
	weapon_description.append_text("[center]%s[/center]" % weapon_resource.description)
	buy_button.text = str(weapon_resource.cost) + " G"


func _on_buy_button_pressed():
	print(weapon_resource.name)
