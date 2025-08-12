extends Resource
class_name BaseItem

var _id: String = ''
var _max_stack: int = 99
var _max_damage: int = 0
var _rarity: int = Rarity.COMMON


func get_id() -> String:
	return _id


func get_splited_id() -> Array:
	return _id.split(':')


func set_id(new_id: String) -> void:
	if _id != '' and _id != new_id:
		push_warning('Item ID already set. It cannot be changed after initialization.')
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


func get_rarity() -> int:
	return _rarity


func set_rarity(new_rarity: int) -> void:
	_rarity = new_rarity


func get_tooltip() -> Array[String]:
	var splited_id: Array = get_splited_id()
	var name_line = '%s [color=%s](%s)[/color]' % [
		CustomTranslation.t('%s.item.%s.name' % splited_id),
		Rarity.get_color(_rarity),
		Rarity.get_tr_name(_rarity)
	]
	return [name_line]


func can_equip(slot) -> bool:
	return slot.get_slot_type() == 0


func on_equip():
	pass


func can_unequip(_slot) -> bool:
	return true


func on_unequip():
	pass


func use():
	pass
