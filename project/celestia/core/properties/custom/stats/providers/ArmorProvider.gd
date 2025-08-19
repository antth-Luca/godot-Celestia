extends BasePropertyProvider
class_name ArmorProvider

var _armor: ArmorProperty


func create() -> ArmorProperty:
	if _armor == null:
		_armor = ArmorProperty.new()
	return _armor


func get_property(prop: DeferredHolder):
	if prop == InitPropProviders.ARMOR:
		return _optional.call()
	return null
