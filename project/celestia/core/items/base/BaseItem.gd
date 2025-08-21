extends Resource
class_name BaseItem

var _id: ResourceLocation = ResourceLocation.EMPTY
var _max_stack: int = 99
var _max_damage: int = 0
var _rarity: BaseRarity = InitRarities.COMMON.get_registered()


func get_id() -> ResourceLocation:
	return _id


func set_id(new_id: ResourceLocation) -> void:
	if _id != ResourceLocation.EMPTY and _id.get_string() != new_id.get_string():
		push_warning('BaseItem: Item ID already set. It cannot be changed after initialization.')
	_id = new_id

func get_max_stack() -> int:
	return _max_stack

func set_max_stack(new_stack: int) -> void:
	if _max_damage != 0: return
	_max_stack = new_stack


func get_durability() -> int:
	return _max_damage


func set_durability(new_damage: int) -> void:
	_max_damage = new_damage
	_max_stack = 1


func get_rarity() -> BaseRarity:
	return _rarity


func set_rarity(new_rarity: BaseRarity) -> void:
	_rarity = new_rarity


func get_tooltip() -> Array[String]:
	var splited_id: Array = _id.get_splited()
	var name_line = '%s [color=%s](%s)[/color]' % [
		CustomTranslation.t('%s.item.%s.name' % splited_id),
		_rarity.get_hex_color(),
		_rarity.get_tr_name()
	]
	return [name_line]


func can_equip(slot: Slot) -> bool:
	return slot.get_slot_type() == 0


func on_equip(slot: Slot):
	pass


func can_unequip(_slot: Slot) -> bool:
	return true


func on_unequip(slot: Slot):
	pass


func use():
	pass
