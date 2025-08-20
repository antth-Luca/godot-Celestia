extends BasePropertyProvider
class_name RangeProvider

var _range: RangeProperty


func create(initial_value: float) -> RangeProperty:
	if _range == null:
		_range = RangeProperty.new(initial_value)
	return _range


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.RANGE:
		return _optional.call(initial_value)
	return null
