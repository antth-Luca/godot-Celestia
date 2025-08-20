extends BasePropertyProvider
class_name ForceProvider

var _force: ForceProperty


func create(initial_value: float) -> ForceProperty:
	if _force == null:
		_force = ForceProperty.new(initial_value)
	return _force


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.FORCE:
		return _optional.call(initial_value)
	return null
