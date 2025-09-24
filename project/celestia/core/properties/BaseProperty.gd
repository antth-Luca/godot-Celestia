extends Resource
class_name BaseProperty

var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('PropertyBaseComponent: Item ID already set. It cannot be changed after initialization.')
		id = new_id

# Another
func create_component() -> void:
	pass


func copy_component(_old_component: BaseProperty) -> void:
	pass


func save_component() -> void:
	pass


func load_component() -> void:
	pass
