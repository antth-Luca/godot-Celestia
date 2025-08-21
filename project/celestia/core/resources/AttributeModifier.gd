extends Resource
class_name AttributeModifier

const expected_operation := ['+', '-']
var _provider_holder: DeferredHolder
var _operation_tag: String


func _init(provider_holder: DeferredHolder, operation_tag: String) -> void:
	if not operation_tag[0] in expected_operation:
		push_error('AttributeModifier: An unexpected operation passed "%s".' % operation_tag[0])
	_provider_holder = provider_holder
	_operation_tag = operation_tag


func get_numeric_value() -> Variant:
	var treated_tag = _operation_tag.substr(1)
	if treated_tag[-1] == '%':
		treated_tag = treated_tag.substr(0, treated_tag.length() - 1)
	if '.' in treated_tag:
		return float(treated_tag)
	return int(treated_tag)


func is_percent() -> bool:
	return '%' in _operation_tag
