extends RefCounted
class_name BasePropertyProvider

var id: ResourceLocation = ResourceLocation.EMPTY:
	get:
		return id
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('BasePropertyProvider: Property ID already set. It cannot be changed after initialization.')
		id = new_id

@warning_ignore("unused_private_class_variable") var _optional := Callable(self, "create")

# Another
func create(_initial_value) -> BaseProperty:
	return null


func get_property(_prop: DeferredHolder, _initial_value):
	pass
