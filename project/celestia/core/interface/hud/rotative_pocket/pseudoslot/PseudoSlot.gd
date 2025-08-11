extends Control

@onready var itemSprite: Sprite2D = $ItemSprite
@onready var itemAmount: Label = $ItemAmount


func _ready():
	EventBus.client_inventory.connect('some_pocket_slot_has_updated', Callable(self, '_handle_pocket_slot_has_updated'))


func _handle_pocket_slot_has_updated(slot_index: int, stack: ItemStack) -> void:
	if slot_index == get_index():
		print('** O slot %s do bolso foi atualizado! **' % get_index())
