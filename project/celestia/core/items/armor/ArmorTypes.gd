extends Object
class_name ArmorTypes

enum { HELMET, CHESTPLATE, LEGGINGS, BOOTS }


static func get_compatible_slot(type_key: int) -> int:
	var compatible_slot: int
	match type_key:
		0:
			compatible_slot = SlotTypes.HEAD
		1:
			compatible_slot = SlotTypes.CHESTPLATE
		2:
			compatible_slot = SlotTypes.LEGS
		3:
			compatible_slot = SlotTypes.FEET
	return compatible_slot
