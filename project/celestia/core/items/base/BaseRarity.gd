class_name BaseRarity

var _id: String = ''
var _hex_color: String = '#FFFFFF'


func get_id() -> String:
	return _id


func get_splited_id() -> Array:
	return _id.split(':')


func set_id(new_id: String) -> void:
	if _id != '' and _id != new_id:
		push_warning('Item ID already set. It cannot be changed after initialization.')
	_id = new_id


func get_hex_color() -> String:
	return _hex_color


func set_hex_color(new_hex: String) -> void:
	var hex_len = new_hex.length()
	if not (hex_len == 6 or (hex_len == 7 and new_hex[0] == '#')):
		push_error('An invalid color HEX code is being passed to BaseRarity when registering.')
	_hex_color = new_hex


func get_tr_name() -> String:
	return CustomTranslation.t('%s.item.rarity.%s' % get_splited_id())
