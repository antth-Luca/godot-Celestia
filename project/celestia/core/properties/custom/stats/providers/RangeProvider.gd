extends BasePropertyProvider
class_name RangeProvider

var _range: RangeProperty


func create() -> RangeProperty:
	if _range == null:
		_range = RangeProperty.new()
	return _range


func get_property(prop: DeferredHolder):
	if prop == InitPropProviders.RANGE:
		return _optional.call()
	return null
