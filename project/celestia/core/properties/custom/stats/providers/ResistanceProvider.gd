extends BasePropertyProvider
class_name ResistanceProvider

var _resist: ResistanceProperty


func create(initial_value: float) -> ResistanceProperty:
	if _resist == null:
		_resist = ResistanceProperty.new(initial_value)
	return _resist


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.RESISTANCE:
		return _optional.call(initial_value)
	return null
