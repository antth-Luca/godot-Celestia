extends Resource
class_name BaseItem

const AnimType: Dictionary = {
	USE = 'use',
	HOLD = 'hold'
}

var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('BaseItem: Item ID already set. It cannot be changed after initialization.')
		id = new_id
var max_stack: int = 99:
	set(new_stack):
		if _durability != 0: return
		max_stack = new_stack
var _durability: int = 0
var material: BaseMaterial = InitMaterials.GENERIC.get_registered()
var rarity: BaseRarity = InitRarities.COMMON.get_registered()
var anim_type: String = AnimType.HOLD

# GETTERS AND SETTERS
# Variables
func set_durability(durability_factor: float = 1):
	_durability = ceil(material.base_max_damage * durability_factor)
	max_stack = 1


func get_tooltip() -> Array[String]:
	var splited_id: Array = id.get_splited()
	var name_line = '%s [color=%s](%s)[/color]' % [
		CustomTranslation.t(Celestia.TRANSLATION_KEY_BASES.ITEM % splited_id),
		rarity.hex_color,
		rarity.get_tr_name()
	]
	return [name_line]

# HANDLERS
func can_equip(slot: Slot) -> bool:
	return slot.slot_type == Slot.Type.GENERIC


func on_equip(_slot: Slot, _player: Player) -> void:
	pass


func can_unequip(_slot: Slot) -> bool:
	return true


func on_unequip(_slot: Slot, _player: Player):
	pass


func use(_player: Player) -> void:
	pass


func consome_durability(damage: int, slot: Slot) -> void:
	if _durability != 0 and damage != 0: _durability -= damage
	if _durability <= 0: break_item(slot)


func break_item(slot: Slot) -> void:
	var invent: InventoryManager = slot.get_inventory_tab()
	invent.inventory[slot.get_index()] = ItemStack.EMPTY
	slot.render_slot()
