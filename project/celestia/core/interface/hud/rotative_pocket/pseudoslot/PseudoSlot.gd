extends Control

@onready var itemSprite: Sprite2D = $ItemSprite
@onready var itemAmount: Label = $ItemAmount


func _ready():
	EventBus.client_inventory.connect('some_pocket_slot_has_updated', Callable(self, '_handle_pocket_slot_has_updated'))


func _handle_pocket_slot_has_updated(slot: Slot, stack: ItemStack) -> void:
	print('>> O slot %s do bolso foi atualizado!' % slot.get_index())
