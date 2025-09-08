extends BaseItem
class_name BaseArmor

enum Type { HELMET, CHESTPLATE, LEGGINGS, BOOTS }

var armor_type: Type
var protection: float

# SUPER
func _init():
	max_stack = 1


func use(player: Player) -> void:
	for c in range(InventoryManager.ARMOR_SLOTS[Slot.Type.HEAD],
			InventoryManager.ARMOR_SLOTS[Slot.Type.FEET] + 1):
		var slot: Slot = player.inventory.get_slot(c)
		var armor_slot_type: String = get_compatible_slot()
		if slot.slot_type == armor_slot_type:
			# TODO: Corrigir tudo aqui...
			var equipped_stack: ItemStack = player.inventory.inventory[c]
			if equipped_stack.is_empty():
				player.inventory.inventory[c] = player.inventory.inventory[0]
				self.on_equip(slot, player)
				player.inventory.inventory[0] = equipped_stack
				slot.render_slot()
			elif equipped_stack.item.can_unequip(slot) and can_equip(slot):
				equipped_stack.item.on_unequip(slot, player)
				player.inventory.inventory[c] = player.inventory.inventory[0]
				self.on_equip(slot, player)
				player.inventory.inventory[0] = equipped_stack
				slot.render_slot(player.inventory.inventory[0])

# HANDLERS
func can_equip(slot: Slot) -> bool:
	var slot_type = slot.slot_type
	return slot_type == Slot.Type.GENERIC or slot_type == get_compatible_slot()


func on_equip(slot: Slot, player: Player) -> void:
	if slot.slot_type == get_compatible_slot():
		var prop = player.entity_data.stats.get_property(InitPropProviders.ARMOR)
		prop.add_armor(protection)


func on_unequip(slot: Slot, player: Player) -> void:
	if slot.slot_type == get_compatible_slot():
		var prop = player.entity_data.stats.get_property(InitPropProviders.ARMOR)
		prop.sub_armor(protection)


func get_compatible_slot() -> String:
	var compatible_slot: String
	match armor_type:
		Type.HELMET:
			compatible_slot = Slot.Type.HEAD
		Type.CHESTPLATE:
			compatible_slot = Slot.Type.CHESTPLATE
		Type.LEGGINGS:
			compatible_slot = Slot.Type.LEGS
		Type.BOOTS:
			compatible_slot = Slot.Type.FEET
	return compatible_slot
