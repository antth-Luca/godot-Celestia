extends BasePropertyProvider
class_name CriticalStrikeProvider

var _crit: CriticalStrikeProperty


func create() -> CriticalStrikeProperty:
	if _crit == null:
		_crit = CriticalStrikeProperty.new()
	return _crit


func get_property(prop: DeferredHolder):
	if prop == InitPropProviders.CRITICAL_STRIKE:
		return _optional.call()
	return null
