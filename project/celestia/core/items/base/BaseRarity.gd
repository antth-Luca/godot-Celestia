extends Resource
class_name BaseRarity

var _id: ResourceLocation = ResourceLocation.EMPTY
var _hex_color: String = '#FFFFFF'


func get_id() -> ResourceLocation:
	return _id


func set_id(new_id: ResourceLocation) -> void:
	if _id != ResourceLocation.EMPTY and _id.get_string() != new_id.get_string():
		push_warning('BaseRarity: Item ID already set. It cannot be changed after initialization.')
	_id = new_id


func get_hex_color() -> String:
	return _hex_color


func set_hex_color(new_hex: String) -> void:
	var hex_len = new_hex.length()
	if not (hex_len == 6 or (hex_len == 7 and new_hex[0] == '#')):
		push_error('An invalid color HEX code is being passed to BaseRarity when registering.')
	_hex_color = new_hex


func get_tr_name() -> String:
	return CustomTranslation.t('%s.item.rarity.%s' % _id.get_splited())
