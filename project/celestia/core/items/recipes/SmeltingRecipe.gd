extends BaseRecipe
class_name SmeltingRecipe

enum WorkstationType {
	CLAY_FURNACE = 3,
	STONE_FURNACE = 4
}

var melting_point: int:
	set(new_point):
		melting_point = max(new_point, 1)

# SUPER
func get_workstation() -> WorkstationType:
	return super.get_workstation()


func set_workstation(station: WorkstationType) -> void:
	super.set_workstation(station)
