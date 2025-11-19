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
	lines.insert(2, '[color=%s]%s[/color]\n' % [
		COMMON_TEXT_COLOR, 'aoba',
	])
	return lines
