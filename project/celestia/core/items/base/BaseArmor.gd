extends BaseItem
class_name BaseArmor

var _armor_type: int = -1
var _protection: float
var _durability_factor: float = 1
var _material: BaseMaterial = InitMaterials.GENERIC.get_registered()

# SUPER
func _init():
	set_max_stack(1)


func get_protection() -> float:
	return _protection


func set_protection(new_protection: float) -> void:
	_protection = new_protection


func get_durability() -> int:
	@warning_ignore("narrowing_conversion")
	return _material.get_base_max_damage() * _durability_factor


func can_equip(slot: Slot) -> bool:
	var slot_type = slot.get_slot_type()
	return is_compatible_slot(slot_type, [
		0, 
		ArmorTypes.get_compatible_slot(_armor_type)
	])


func on_equip(slot: Slot) -> void:
	if is_compatible_slot(slot.get_slot_type(), [ArmorTypes.get_compatible_slot(_armor_type)]):
		var player: Player = slot.get_inventory_tab().get_inventory_panel().get_ui().get_player()
		var prop = player.stats.get_property(InitPropProviders.ARMOR)
		prop.add_armor(get_protection())


func on_unequip(slot: Slot) -> void:
	if is_compatible_slot(slot.get_slot_type(), [ArmorTypes.get_compatible_slot(_armor_type)]):
		var player: Player = slot.get_inventory_tab().get_inventory_panel().get_ui().get_player()
		var prop = player.stats.get_property(InitPropProviders.ARMOR)
		prop.sub_armor(get_protection())

# GETTERS AND SETTERS
func get_armor_type() -> int:
	return _armor_type


func set_armor_type(new_type: int) -> void:
	if new_type < 0 or new_type > 3:
		push_error('BaseArmor: Armor type selected invalid.')
	_armor_type = new_type


func set_durability_factor(new_factor: float) -> void:
	if new_factor < 1: return
	_durability_factor = new_factor


func get_material() -> BaseMaterial:
	return _material


func set_material(new_material: BaseMaterial) -> void:
	_material = new_material


func is_compatible_slot(slot_type: int, allowed: Array[int]) -> bool:
	for allow in allowed:
		if slot_type == allow:
			return true
	return false
