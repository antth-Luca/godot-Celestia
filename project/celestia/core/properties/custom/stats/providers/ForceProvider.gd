extends BasePropertyProvider
class_name ForceProvider

var _force: ForceProperty


func create() -> ForceProperty:
	if _force == null:
		_force = ForceProperty.new()
	return _force


func get_property(prop: DeferredHolder):
	if prop == InitPropProviders.FORCE:
		return _optional.call()
	return null
