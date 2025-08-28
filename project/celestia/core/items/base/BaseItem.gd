extends Resource
class_name BaseItem

var id: ResourceLocation = ResourceLocation.EMPTY:
	get:
		return id
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('BaseItem: Item ID already set. It cannot be changed after initialization.')
		id = new_id

var max_stack: int = 99:
	get:
		return max_stack
	set(new_stack):
		if max_damage != 0: return
		max_stack = new_stack

var max_damage: int = 0:
	get:
		return max_damage
	set(new_damage):
		max_damage = new_damage
		max_stack = 1

var rarity: BaseRarity = InitRarities.COMMON.get_registered():
	get:
		return rarity
	set(new_rarity):
		rarity = new_rarity


func get_tooltip() -> Array[String]:
	var splited_id: Array = id.get_splited()
	var name_line = '%s [color=%s](%s)[/color]' % [
		CustomTranslation.t('%s.item.%s.name' % splited_id),
		rarity.hex_color,
		rarity.get_tr_name()
	]
	return [name_line]


func can_equip(slot: Slot) -> bool:
	return slot.slot_type == 0


func on_equip(_slot: Slot):
	pass


func can_unequip(_slot: Slot) -> bool:
	return true


func on_unequip(_slot: Slot):
	pass


func use():
	pass
