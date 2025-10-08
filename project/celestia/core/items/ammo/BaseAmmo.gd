extends BaseItem
class_name BaseAmmo

# SUPER
# Handlers
func can_equip(slot: BaseSlot) -> bool:
	return slot.slot_type in [
		BaseSlot.Type.GENERIC,
		BaseSlot.Type.AMMO
	]
