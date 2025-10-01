extends BaseItem
class_name BaseFuel

var energy: int = 1:
	set(new_energy):
		energy = max(new_energy, 1)

# SUPER
func can_equip(slot: BaseSlot) -> bool:
	var slot_type = slot.slot_type
	return slot_type in [
		BaseSlot.Type.GENERIC,
		BaseSlot.Type.INPUT,
		BaseSlot.Type.FUEL
	]
