extends BaseItem
class_name BaseArmor

enum Type { HELMET, CHESTPLATE, LEGGINGS, BOOTS }

var armor_type: Type
var protection: float
var durability_factor: float = 1:
	set(new_factor):
		if new_factor < 1: return
		durability_factor = new_factor
var material: BaseMaterial = InitMaterials.GENERIC.get_registered()

# SUPER
func _init():
	max_stack = 1

# HANDLERS
func get_durability() -> int:
	return ceil(material.base_max_damage * durability_factor)


func can_equip(slot: Slot) -> bool:
	var slot_type = slot.slot_type
	return slot_type == Slot.Type.GENERIC or slot_type == get_compatible_slot()


func on_equip(slot: Slot) -> void:
	if slot.slot_type == get_compatible_slot():
		var player: Player = slot.get_inventory_tab().get_inventory_panel().get_ui().get_player()
		var prop = player.entity_data.stats.get_property(InitPropProviders.ARMOR)
		prop.add_armor(protection)


func on_unequip(slot: Slot) -> void:
	if slot.slot_type == get_compatible_slot():
		var player: Player = slot.get_inventory_tab().get_inventory_panel().get_ui().get_player()
		var prop = player.entity_data.stats.get_property(InitPropProviders.ARMOR)
		prop.sub_armor(protection)


func get_compatible_slot() -> String:
	var compatible_slot: String
	match armor_type:
		Type.HELMET:
			compatible_slot = Slot.Type.HEAD
		Type.CHESTPLATE:
			compatible_slot = Slot.Type.CHESTPLATE
		Type.LEGGINGS:
			compatible_slot = Slot.Type.LEGS
		Type.BOOTS:
			compatible_slot = Slot.Type.FEET
	return compatible_slot
