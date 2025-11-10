extends BaseStructure
class_name Farmland

var has_seed: bool = false
var is_growing: bool = false
var needs_water: bool = false

# GODOT
func _init() -> void:
	structure_data = StructureData.new(
		[
			AxeTool.get_static_comparable_name(),
			PickaxeTool.get_static_comparable_name(),
			SwordTool.get_static_comparable_name()
		],
		[
			InitMaterials.STONE.get_registered()
		],
		PropertyManager.create_manager({
			InitPropProviders.HEALTH: 1
		})
	)

# SUPER
# Main
func add_highlight() -> void:
	TEXTURE.material.set_shader_parameter('enabled', true)


func remove_highlight() -> void:
	TEXTURE.material.set_shader_parameter('enabled', false)

# MAIN
func on_interact(_entity: LivingEntity) -> void: pass


func destroy(_attacker: LivingEntity) -> void: pass
