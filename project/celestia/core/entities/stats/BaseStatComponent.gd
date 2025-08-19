extends Node
class_name BaseStatComponent

var _id: ResourceLocation = ResourceLocation.EMPTY

# Getters and Setters
func get_id() -> ResourceLocation:
	return _id


func get_splited_id() -> Array:
	return _id.get_splited()


func set_id(new_id: ResourceLocation) -> void:
	var current_string_id: String = _id.get_string()
	if current_string_id != ResourceLocation.EMPTY.get_string() and current_string_id != new_id.get_string():
		push_warning('BaseStatComponent: Item ID already set. It cannot be changed after initialization.')
	_id = new_id

# Another
func create_component() -> void:
	pass


func copy_component(_old_component: BaseStatComponent) -> void:
	pass


func save_component() -> void:
	pass


func load_component() -> void:
	pass
