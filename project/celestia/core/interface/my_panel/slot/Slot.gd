extends Button
class_name Slot

signal slot_rendered(stack: ItemStack)
signal slot_cleaned()
signal slot_hovered(slot: Slot)
signal slot_unhovered()

const Type: Dictionary =  {
	GENERIC = 'generic',
	FUEL = 'fuel',
	HEAD = 'head',
	CHESTPLATE = 'chestplate',
	LEGS = 'legs',
	FEET = 'feet',
	RELIC = 'relic',
	AMMO = 'ammo'
}

@export_enum(
	'generic',
	'fuel',
	'head',
	'chestplate',
	'legs',
	'feet',
	'relic',
	'ammo'
) var slot_type: String = Type.GENERIC

@onready var slotTypeSprite: Sprite2D = $SlotType
@onready var itemSprite: Sprite2D = $ItemSprite
@onready var itemAmount: Label = $ItemAmount
var parent_inventory: InventoryManager  # Filled by InventoryManager#_ready()
var stack: ItemStack:
	set(new_stack):
		if not new_stack: return
		stack = new_stack
		if new_stack.is_empty():
			clear_slot()
			return
		else:
			render_slot()
		


func _ready():
	if slot_type != Type.GENERIC:
		slotTypeSprite.texture = load(Celestia.SLOT_TYPE_SPRITE_PATH % [Celestia.GAME_ID, slot_type])

# GETTERS AND SETTERS
# Node
func get_inventory_tab() -> InventoryManager:
	return get_parent().get_parent()

# HANDLERS
func render_slot() -> void:
	slotTypeSprite.visible = false
	itemSprite.texture = load(Celestia.ITEM_SPRITE_PATH % stack.item.id.get_splited())
	itemSprite.visible = true
	if stack.amount > 1:
		itemAmount.text = str(stack.amount)
		itemAmount.visible = true
	else:
		itemAmount.visible = false
	var slot_index: int = get_index()
	if slot_index == InventoryManager.MIN_SLOTS:
		var player: Player = parent_inventory.player
		player.hand.ITEM_HAND_TEXTURE.texture = itemSprite.texture
	if slot_index in [0, 1, 2, 3]:
		emit_signal('slot_rendered', stack)


func clear_slot() -> void:
	slotTypeSprite.visible = true
	itemSprite.texture = null
	itemAmount.visible = false
	var slot_index: int = get_index()
	if slot_index == InventoryManager.MIN_SLOTS:
		var player: Player = parent_inventory.player
		if player: player.hand.ITEM_HAND_TEXTURE.texture = null
	if slot_index in [0, 1, 2, 3]:
		emit_signal('slot_cleaned')


func _on_mouse_entered():
	emit_signal('slot_hovered', self)


func _on_mouse_exited():
	emit_signal('slot_unhovered')

# SIGNALS
func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				parent_inventory._handle_left_click_on_slot(self)
			MOUSE_BUTTON_MIDDLE:
				parent_inventory._handle_middle_click_on_slot(self)
			MOUSE_BUTTON_RIGHT:
				parent_inventory._handle_right_click_on_slot(self)
