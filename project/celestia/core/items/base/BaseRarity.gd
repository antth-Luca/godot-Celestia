extends Resource
class_name BaseRarity

var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('BaseRarity: Item ID already set. It cannot be changed after initialization.')
		id = new_id

var hex_color: String = '#FFFFFF':
	set(new_hex):
		var hex_len = new_hex.length()
		if not (hex_len == 6 or (hex_len == 7 and new_hex[0] == '#')):
			push_error('An invalid color HEX code is being passed to BaseRarity when registering.')
		hex_color = new_hex


func get_tr_name() -> String:
	return CustomTranslation.t(Celestia.TRANSLATION_KEY_BASES.RARITY % id.get_splited())
