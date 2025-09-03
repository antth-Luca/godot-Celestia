extends Control
class_name PseudoSlot

@onready var itemSprite: Sprite2D = $ItemSprite
@onready var itemAmount: Label = $ItemAmount

# GODOT
func _ready():
	var slot: Slot = get_rotative_pocket().get_hud().get_ui().get_invent_panel().get_inventory_tab().get_slot(get_index())
	slot.connect('slot_rendered', Callable(self, "render_slot"))
	slot.connect('slot_cleaned', Callable(self, "clear_slot"))
	clear_slot()

# GETTERS AND SETTERS
# Nodes
func get_rotative_pocket():
	return get_parent().get_parent()

# MAIN
func render_slot(stack: ItemStack) -> void:
	itemSprite.texture = load('res://assets/%s/textures/items/%s.png' % stack.item.id.get_splited())
	itemSprite.visible = true
	if stack.amount > 1:
		itemAmount.text = str(stack.amount)
		itemAmount.visible = true
	else:
		itemAmount.visible = false


func clear_slot() -> void:
	itemSprite.visible = false
	itemAmount.visible = false

# HANDLRES
func _handle_pocket_slot_has_rendered(slot_index: int, stack: ItemStack) -> void:
	if slot_index == get_index():
		render_slot(stack)


func _handle_pocket_slot_has_cleaned(slot_index: int) -> void:
	if slot_index == get_index():
		clear_slot()
