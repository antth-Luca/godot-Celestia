extends Button

const slot_types = [
	"generic",
	"head",
	"chestplate",
	"legs",
	"feet",
	"relic",
	"ammo"
]

@export var defined_slot_type: int

@onready var slotTypeSprite: Sprite2D = $SlotType
@onready var itemSprite: Sprite2D = $ItemSprite
@onready var itemAmount: Label = $ItemAmount


func _ready():
	if defined_slot_type < 0 or defined_slot_type > 6:
		push_error("Slot type selected invalid.")
	elif defined_slot_type != 0:
		slotTypeSprite.texture = load("res://assets/interface/inventory/slots/types/" + slot_types[defined_slot_type] + ".png")


func render_slot(item_slot: ItemStack) -> void:
	slotTypeSprite.visible = false
	itemSprite.texture = load("res://assets/textures/items/" + item_slot.item_id + ".png")
	itemSprite.visible = true
	if item_slot.amount > 1:
		itemAmount.text = str(item_slot.amount)
		itemAmount.visible = true
	else:
		itemAmount.visible = false


func clear_slot() -> void:
	slotTypeSprite.visible = true
	itemSprite.visible = false
	itemAmount.visible = false
