extends BasePropertyProvider
class_name ArmorProvider

var _armor: ArmorProperty


func create(initial_value: float) -> ArmorProperty:
	if _armor == null:
		_armor = ArmorProperty.new(initial_value)
	return _armor


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.ARMOR:
		return _optional.call(initial_value)
	return null
