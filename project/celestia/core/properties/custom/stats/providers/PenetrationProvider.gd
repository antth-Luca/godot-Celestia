extends BasePropertyProvider
class_name PenetrationProvider

var _pen: PenetrationProperty


func create(initial_value: float) -> PenetrationProperty:
	if _pen == null:
		_pen = PenetrationProperty.new(initial_value)
	return _pen


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.PENETRATION:
		return _optional.call(initial_value)
	return null
