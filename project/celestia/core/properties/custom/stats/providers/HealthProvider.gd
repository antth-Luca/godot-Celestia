extends BasePropertyProvider
class_name HealthProvider

var _health: HealthProperty


func create() -> HealthProperty:
	if _health == null:
		_health = HealthProperty.new()
	return _health


func get_property(prop: DeferredHolder):
	if prop == InitPropProviders.HEALTH:
		return _optional.call()
	return null
