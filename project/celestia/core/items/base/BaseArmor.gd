extends BaseItem
class_name BaseArmor


var _armor_attribute: int = 0
var _armor_type: int = -1
var _material: BaseMaterial = InitMaterials.GENERIC
var _max_damage_utilization: float = 1

# SUPER
func _init():
	set_max_stack(1)
	set_durability(_material.get_base_max_damage() * _max_damage_utilization)


func can_equip(slot: Slot) -> bool:
	return slot.get_slot_type() == ArmorTypes.get_compatible_slot(_armor_type)


func on_equip() -> void:
	pass


func on_unequip() -> void:
	pass

# GETTERS AND SETTERS
func get_armor_attribute() -> int:
	return _armor_attribute


func set_armor_attribute(new_armor: int) -> void:
	if new_armor < 1: return
	_armor_attribute = new_armor


func get_armor_type() -> int:
	return _armor_type


func set_armor_type(new_type: int) -> void:
	if _armor_type < 0 or _armor_type > 3:
		push_error('BaseArmor: Armor type selected invalid.')
	_armor_type = new_type


func get_material() -> BaseMaterial:
	return _material


func set_material(new_material: BaseMaterial) -> void:
	_material = new_material

#HANDLES
func get_attribute_modifiers():
	return
