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


func use():
	pass
