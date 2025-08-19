extends BasePropertyProvider
class_name UseSpeedProvider

var _use: UseSpeedProperty


func create() -> UseSpeedProperty:
	if _use == null:
		_use = UseSpeedProperty.new()
	return _use


func get_property(prop: DeferredHolder):
	if prop == InitPropProviders.USE_SPEED:
		return _optional.call()
	return null
