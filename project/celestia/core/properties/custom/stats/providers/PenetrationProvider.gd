extends BasePropertyProvider
class_name PenetrationProvider

var _pen: PenetrationProperty


func create() -> PenetrationProperty:
	if _pen == null:
		_pen = PenetrationProperty.new()
	return _pen


func get_property(prop: DeferredHolder):
	if prop == InitPropProviders.PENETRATION:
		return _optional.call()
	return null
