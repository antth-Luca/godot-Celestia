extends Resource
class_name LootBox

const _BASE_GROUP: Dictionary = {
	'cycles': {
		'min': 1,
		'max': 1
	},
	'possible_outputs': []
}
const _BASE_OUTPUT: Dictionary = {
	'item': null,
	'count': {
		'min': 1,
		'max': 1
	},
	'chance': 1.0
}

var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('LootTable: Table ID already set. It cannot be changed after initialization.')
		id = new_id
var _groups := []

# MAIN
func add_group(min_max_cycles: Array[int], output: Dictionary[String, Variant]) -> void:
	if min_max_cycles.size() != 2:
		push_warning('LootBox: The ‘min_max_cycles’ must have a size equal to 2, a minimum number of cycles, and a maximum number of cycles.')
	if not output['item'].get_registered() is BaseItem:
		push_warning('LootBox: ')
	var new_group = _BASE_GROUP.duplicate()
	new_group['cycles']['min'] = min_max_cycles.front()
	new_group['cycles']['max'] = min_max_cycles.back()
