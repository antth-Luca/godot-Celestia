extends Control

@onready var itemSprite: Sprite2D = $ItemSprite
@onready var itemAmount: Label = $ItemAmount

# GODOT
func _ready():
	EventBus.client_inventory.connect('some_pocket_slot_has_rendered', Callable(self, '_handle_pocket_slot_has_rendered'))
	EventBus.client_inventory.connect('some_pocket_slot_has_cleaned', Callable(self, '_handle_pocket_slot_has_cleaned'))
	clear_slot()

# MAIN
func render_slot(stack: ItemStack) -> void:
	itemSprite.texture = load('res://assets/%s/textures/items/%s.png' % stack.get_item().get_splited_id())
	itemSprite.visible = true
	if stack.get_amount() > 1:
		itemAmount.text = str(stack.get_amount())
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
