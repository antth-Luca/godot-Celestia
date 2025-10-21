extends BaseItem
class_name BaseAmmo

# SUPER
# Getters and Setters
func get_tooltip() -> Array[String]:
	var lines = super.get_tooltip()
	lines.append('[color=%s]%s %s[/color]\n' % [
		COMMON_TEXT_COLOR,
		tr(Celestia.TRANSLATION_KEY_BASES.SECTION_TITLE % 'slot_destination'),
		tr(Celestia.TRANSLATION_KEY_BASES.SLOT % BaseSlot.Type.AMMO)
	])
	return lines

# Handlers
func can_equip(slot: BaseSlot) -> bool:
	return slot.slot_type in [
		BaseSlot.Type.GENERIC,
		BaseSlot.Type.AMMO
	]
