extends BaseItem
class_name LinkingStaffItem

var link: BaseStructure

# SUPER
# Godot
func _init() -> void:
	max_stack = 1
	material = InitMaterials.GENERIC.get_registered()
	set_durability(128)

# Getters and Setters
static func get_static_comparable_name() -> String:
	return 'LinkingStaff'


func get_comparable_name() -> String:
	return LinkingStaffItem.get_static_comparable_name()


func get_tooltip() -> Array[String]:
	var lines = super.get_tooltip()
	var staff_line: String = '[color=%s]%s\n' % [
		COMMON_TEXT_COLOR,
		tr(Celestia.TRANSLATION_KEY_BASES.ITEM_DESC % id.path),
	]
	if link:
		var coords: Vector2 = link.global_position
		staff_line += '%s: %s [X: %s, Y: %s]' % [
			tr('item.%s.stored_link' % id.path), tr(Celestia.TRANSLATION_KEY_BASES.STRUCTURE % link.id.path),
			coords.x, coords.y
		]
	staff_line += '[/color]\n'
	lines.insert(2, staff_line)
	return lines
