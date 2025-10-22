extends BaseItem
class_name BaseAmmo

# SUPER
# Getters and Setters
static func get_static_comparable_name() -> String:
	return 'BaseAmmo'


func get_comparable_name() -> String:
	return BaseAmmo.get_static_comparable_name()

func get_tooltip() -> Array[String]:
	var lines = super.get_tooltip()
	lines.append('[color=%s]%s %s[/color]\n' % [
		COMMON_TEXT_COLOR,
		tr(Celestia.TRANSLATION_KEY_BASES.SECTION_TITLE % 'slot_destination'),
		tr(Celestia.TRANSLATION_KEY_BASES.SLOT % BaseSlot.Type.AMMO)
	])
	return lines

# Main
func copy(copy_obj: Variant = BaseAmmo.new()) -> Variant:
	return super.copy(copy_obj)

# Handlers
func can_equip(slot: BaseSlot) -> bool:
	return slot.slot_type in [
		BaseSlot.Type.GENERIC,
		BaseSlot.Type.AMMO
	]
