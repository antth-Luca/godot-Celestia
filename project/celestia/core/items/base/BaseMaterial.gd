extends Object
class_name BaseMaterial

var _id: ResourceLocation
var _base_max_damage: int = 1
var _efficiency: int = -1


func get_id() -> ResourceLocation:
	return _id


func get_splited_id() -> Array:
	return _id.get_splited() if _id else ['']


func set_id(new_id: ResourceLocation) -> void:
	if _id != null and _id.get_string() != new_id.get_string():
		push_warning('Item ID already set. It cannot be changed after initialization.')
	_id = new_id


func get_base_max_damage() -> int:
	return _base_max_damage


func set_base_max_damage(new_max_damage: int) -> void:
	if new_max_damage >= 0: return
	_base_max_damage = new_max_damage


func get_efficiency() -> int:
	return _efficiency


func set_efficiency(new_efficiency: int) -> void:
	if new_efficiency < -1: return
	_efficiency = new_efficiency
