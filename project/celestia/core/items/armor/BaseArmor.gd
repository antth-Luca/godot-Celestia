extends BaseItem
class_name BaseArmor

enum Type { HELMET, CHESTPLATE, LEGGINGS, BOOTS }

var armor_type: Type
var protection: float

# SUPER
# Godot
func _init():
	max_stack = 1

# Getters and Setters
static func get_static_comparable_name() -> String:
	return 'BaseArmor'


func get_comparable_name() -> String:
	return BaseArmor.get_static_comparable_name()

func get_tooltip() -> Array[String]:
	var lines = super.get_tooltip()
	lines.insert(2, '[color=%s]%s %s:\n  %s %s[/color]\n' % [
		COMMON_TEXT_COLOR,
		tr(Celestia.TRANSLATION_KEY_BASES.SECTION_TITLE % 'when_slot'),
		tr(Celestia.TRANSLATION_KEY_BASES.SLOT % get_compatible_slot()),
		protection, tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'AM')
	])
	return lines

# Main
func copy(copy_obj: Variant = BaseArmor.new()) -> Variant:
	copy_obj = super.copy(copy_obj)
	copy_obj.armor_type = armor_type
	copy_obj.protection = protection
	return copy_obj

# Handlers
func can_equip(slot: BaseSlot) -> bool:
	var slot_type = slot.slot_type
	return slot_type in [
		BaseSlot.Type.GENERIC,
		BaseSlot.Type.INPUT,
		get_compatible_slot()
	]


func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type == get_compatible_slot():
		var prop = player.entity_data.stats.get_property(InitPropProviders.ARMOR)
		prop.add_armor(protection)


func on_unequip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type == get_compatible_slot():
		var prop = player.entity_data.stats.get_property(InitPropProviders.ARMOR)
		prop.sub_armor(protection)


func use(player: Player) -> void:
	var target_slot: BaseSlot = player.inventory.get_armor(get_compatible_slot()).front()
	var hand_slot: BaseSlot = player.inventory.get_hand()
	if target_slot.stack.is_empty():
		if can_equip(target_slot):
			hand_slot.stack.item.on_unequip(hand_slot, player)
			target_slot.stack = hand_slot.stack
			target_slot.stack.item.on_equip(target_slot, player)
			hand_slot.stack = ItemStack.EMPTY
	else:
		if target_slot.stack.item.can_unequip(target_slot) and can_equip(target_slot):
			var temp: ItemStack = target_slot.stack
			temp.item.on_unequip(target_slot, player)
			target_slot.stack = hand_slot.stack
			hand_slot.stack.item.on_equip(target_slot, player)
			hand_slot.stack = temp

# HANDLERS
func get_compatible_slot() -> String:
	var compatible_slot: String
	match armor_type:
		Type.HELMET:
			compatible_slot = BaseSlot.Type.HEAD
		Type.CHESTPLATE:
			compatible_slot = BaseSlot.Type.CHESTPLATE
		Type.LEGGINGS:
			compatible_slot = BaseSlot.Type.LEGS
		Type.BOOTS:
			compatible_slot = BaseSlot.Type.FEET
	return compatible_slot
