extends BasePropertyProvider
class_name DefenseReductionProvider

var _def_r: DefenseReductionProperty


func create(initial_value: float) -> DefenseReductionProperty:
	if _def_r == null:
		_def_r = DefenseReductionProperty.new(initial_value)
	return _def_r


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.DEFENSE_REDUCTION:
		return _optional.call(initial_value)
	return null
