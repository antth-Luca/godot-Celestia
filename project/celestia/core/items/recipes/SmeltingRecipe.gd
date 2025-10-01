extends BaseRecipe
class_name SmeltingRecipe

enum WorkstationType {
	CLAY_FURNACE,
	STONE_FURNACE
}

# SUPER
func get_workstation() -> WorkstationType:
	return super.get_workstation()


func set_workstation(station: WorkstationType) -> void:
	super.set_workstation(station)
