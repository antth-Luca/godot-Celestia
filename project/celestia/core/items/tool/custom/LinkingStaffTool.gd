extends BaseTool
class_name LinkingStaffTool

# SUPER
# Godot
func _init() -> void:
	super._init()
	material = InitMaterials.GENERIC.get_registered()
	set_durability(128)
