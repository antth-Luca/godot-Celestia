extends BasePropertyProvider
class_name ManaProvider

var _mana: ManaProperty


func create(initial_value: float) -> ManaProperty:
	if _mana == null:
		_mana = ManaProperty.new(initial_value)
	return _mana


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.MANA:
		return _optional.call(initial_value)
	return null
