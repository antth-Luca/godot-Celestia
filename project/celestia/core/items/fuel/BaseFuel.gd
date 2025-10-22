extends BaseItem
class_name BaseFuel

var energy: int = 1:
	set(new_energy):
		energy = max(new_energy, 1)

# SUPER
# Getters and Setters
static func get_static_comparable_name() -> String:
	return 'BaseFuel'


func get_comparable_name() -> String:
	return BaseFuel.get_static_comparable_name()


func get_tooltip() -> Array[String]:
	var lines = super.get_tooltip()
	lines.append('[color=%s]%s: %s[/color]\n' % [
		COMMON_TEXT_COLOR,
		tr(Celestia.TRANSLATION_KEY_BASES.SECTION_TITLE % 'energy'),
		energy
	])
	return lines

# Main
func copy(copy_obj: Variant = BaseFuel.new()) -> Variant:
	copy_obj = super.copy(copy_obj)
	copy_obj.energy = energy
	return copy_obj

# Handlers
func can_equip(slot: BaseSlot) -> bool:
	var slot_type = slot.slot_type
	return slot_type in [
		BaseSlot.Type.GENERIC,
		BaseSlot.Type.INPUT,
		BaseSlot.Type.FUEL
	]
