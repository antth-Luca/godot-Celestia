extends Resource
class_name BaseMaterial

var id: ResourceLocation = ResourceLocation.EMPTY:
	get:
		return id
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('BaseMaterial: Item ID already set. It cannot be changed after initialization.')
		id = new_id

var base_max_damage: int = 1:
	get:
		return base_max_damage
	set(new_max_damage):
		if new_max_damage >= 0: return
		base_max_damage = new_max_damage

var efficiency: int = -1:
	get:
		return efficiency
	set(new_efficiency):
		if new_efficiency < -1: return
		efficiency = new_efficiency
