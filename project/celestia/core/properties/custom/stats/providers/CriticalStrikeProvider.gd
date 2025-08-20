extends BasePropertyProvider
class_name CriticalStrikeProvider

var _crit: CriticalStrikeProperty


func create(initial_value: float) -> CriticalStrikeProperty:
	if _crit == null:
		_crit = CriticalStrikeProperty.new(initial_value)
	return _crit


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.CRITICAL_STRIKE:
		return _optional.call(initial_value)
	return null
