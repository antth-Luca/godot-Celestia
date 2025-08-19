extends BasePropertyProvider
class_name DefenseReductionProvider

var _def_r: DefenseReductionProperty


func create() -> DefenseReductionProperty:
	if _def_r == null:
		_def_r = DefenseReductionProperty.new()
	return _def_r


func get_property(prop: DeferredHolder):
	if prop == InitPropProviders.DEFENSE_REDUCTION:
		return _optional.call()
	return null
