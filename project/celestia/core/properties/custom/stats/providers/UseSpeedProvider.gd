extends BasePropertyProvider
class_name UseSpeedProvider

var _use: UseSpeedProperty


func create(initial_value: float) -> UseSpeedProperty:
	if _use == null:
		_use = UseSpeedProperty.new(initial_value)
	return _use


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.USE_SPEED:
		return _optional.call(initial_value)
	return null
