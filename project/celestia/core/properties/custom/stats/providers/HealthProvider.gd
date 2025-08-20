extends BasePropertyProvider
class_name HealthProvider

var _health: HealthProperty


func create(initial_value: float) -> HealthProperty:
	if _health == null:
		_health = HealthProperty.new(initial_value)
	return _health


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.HEALTH:
		return _optional.call(initial_value)
	return null
