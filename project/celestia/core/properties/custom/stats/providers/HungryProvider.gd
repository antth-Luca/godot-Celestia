extends BasePropertyProvider
class_name HungryProvider

var _hungry: HungryProperty


func create(initial_value: int) -> HungryProperty:
	if _hungry == null:
		_hungry = HungryProperty.new(initial_value)
	return _hungry


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.HUNGRY:
		return _optional.call(initial_value)
	return null
