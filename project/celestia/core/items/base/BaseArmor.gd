extends BaseItem
class_name BaseArmor

var armor_type: int = -1:
	get:
		return armor_type
	set(new_type):
		if new_type < 0 or new_type > 3:
			push_error('BaseArmor: Armor type selected invalid.')
		armor_type = new_type

var protection: float:
	get:
		return protection
	set(new_protection):
		protection = new_protection

var durability_factor: float = 1:
	get:
		return durability_factor
	set(new_factor):
		if new_factor < 1: return
		durability_factor = new_factor

var material: BaseMaterial = InitMaterials.GENERIC.get_registered():
	get:
		return material
	set(new_material):
		material = new_material

# SUPER
func _init():
	max_stack = 1

# HANDLERS
func get_durability() -> int:
	return ceil(material.base_max_damage * durability_factor)


func can_equip(slot: Slot) -> bool:
	var slot_type = slot.slot_type
	return is_compatible_slot(slot_type, [
		0, 
		ArmorTypes.get_compatible_slot(armor_type)
	])


func on_equip(slot: Slot) -> void:
	if is_compatible_slot(slot.slot_type, [ArmorTypes.get_compatible_slot(armor_type)]):
		var player: Player = slot.get_inventory_tab().get_inventory_panel().get_ui().get_player()
		var prop = player.stats.get_property(InitPropProviders.ARMOR)
		prop.add_armor(protection)


func on_unequip(slot: Slot) -> void:
	if is_compatible_slot(slot.slot_type, [ArmorTypes.get_compatible_slot(armor_type)]):
		var player: Player = slot.get_inventory_tab().get_inventory_panel().get_ui().get_player()
		var prop = player.stats.get_property(InitPropProviders.ARMOR)
		prop.sub_armor(protection)


func is_compatible_slot(slot_type: int, allowed: Array[int]) -> bool:
	for allow in allowed:
		if slot_type == allow:
			return true
	return false
