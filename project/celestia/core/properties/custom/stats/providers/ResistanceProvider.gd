extends BasePropertyProvider
class_name ResistanceProvider

var _resist: ResistanceProperty


func create() -> ResistanceProperty:
	if _resist == null:
		_resist = ResistanceProperty.new()
	return _resist


func get_property(prop: DeferredHolder):
	if prop == InitPropProviders.RESISTANCE:
		return _optional.call()
	return null
