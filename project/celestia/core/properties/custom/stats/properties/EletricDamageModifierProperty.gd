extends BaseProperty
class_name EletricDamageModifierProperty

var mod: float


func _init(initial_value: float):
	set_modifier(initial_value)

# Move Speed
func get_modifier() -> float:
	return mod


func set_modifier(newMOD: float) -> void:
	mod = newMOD


func add_modifier(addMOD: float) -> void:
	set_modifier(mod + addMOD)


func sub_modifier(subMOD: float) -> void:
	set_modifier(mod - subMOD)
