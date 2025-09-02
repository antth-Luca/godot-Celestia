extends BasePropertyProvider
class_name StaminaProvider

var _health: StaminaProperty


func create(initial_value: int) -> StaminaProperty:
	if _health == null:
		_health = StaminaProperty.new(initial_value)
	return _health


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.STAMINA:
		return _optional.call(initial_value)
	return null
