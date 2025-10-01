extends Control
class_name HUDPocketSlot

@onready var itemSprite: Sprite2D = $ItemSprite
@onready var itemAmount: Label = $ItemAmount

# GODOT
func _ready():
	var slot: BaseSlot = get_rotative_pocket().get_hud().get_ui().get_invent_panel().get_inventory_tab().get_slot(get_index())
	slot.connect('slot_rendered', Callable(self, "render_slot"))
	slot.connect('slot_cleaned', Callable(self, "clear_slot"))
	clear_slot()

# GETTERS AND SETTERS
# Nodes
func get_rotative_pocket():
	return get_parent().get_parent()

# MAIN
func render_slot(stack: ItemStack) -> void:
	itemSprite.texture = load(Celestia.ITEM_SPRITE_PATH % stack.item.id.get_splited())
	itemSprite.visible = true
	if stack.amount > 1:
		itemAmount.text = str(stack.amount)
		itemAmount.visible = true
	else:
		itemAmount.visible = false


func clear_slot() -> void:
	itemSprite.visible = false
	itemAmount.visible = false
