extends RefCounted
class_name BasePropertyProvider

var _id: ResourceLocation = ResourceLocation.EMPTY
@warning_ignore("unused_private_class_variable") var _optional := Callable(self, "create")


# Muito em breve sairá!
func get_id() -> ResourceLocation:
	return _id


func get_splited_id() -> Array:
	return _id.get_splited()


func set_id(new_id: ResourceLocation) -> void:
	var current_string_id: String = _id.get_string()
	if current_string_id != ResourceLocation.EMPTY.get_string() and current_string_id != new_id.get_string():
		push_warning('BasePropertyProvider: Property ID already set. It cannot be changed after initialization.')
	_id = new_id

# Será mantido!
func create(_initial_value) -> BaseProperty:
	return null


func get_property(_prop: DeferredHolder, _initial_value):
	pass
