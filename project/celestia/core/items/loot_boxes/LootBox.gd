extends Resource
class_name LootBox

const _BASE_OUTPUT: Dictionary = {
	'item': null,
	'count': {
		'min': 1,
		'max': 1
	},
	'weight': 1.0
}

var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('LootTable: Table ID already set. It cannot be changed after initialization.')
		id = new_id
var _cycles: Dictionary[String, int]
var _bonus_cycles: int = 0:
	set(new_bonus):
		if new_bonus < 1:
			push_warning('LootBox: The minimum number of bonus cycles is 1.')
		_bonus_cycles = new_bonus
var _possible_outputs: Array[Dictionary] = []

# GETTERS AND SETTERS
func set_cycles(min_cycles: int, max_cycles: int) -> void:
	if min_cycles < 1:
			push_warning('LootBox: The minimum number of cycles is 1.')
	_cycles = { 'min': min_cycles, 'max': max_cycles }


func add_output(item: DeferredHolder, min_count: int, max_count: int, weight: float) -> void:
	var new_output = _BASE_OUTPUT.duplicate()
	if not item.get_registered() is BaseItem:
		push_warning('LootBox/output: The ‘item’ must be a BaseItem.')
	new_output['item'] = item
	if min_count < 0:
		push_warning('LootBox/output: The minimum number of amount is 1.')
	new_output['count'] = { 'min': min_count, 'max': max_count }
	new_output['weight'] = weight
	_possible_outputs.append(new_output)

# MAIN
func get_sorted_output(player: Player) -> Array[ItemStack]:
	var outputs: Array[ItemStack] = []
	var cycles: int = randi_range(_cycles['min'], _cycles['max'])
	cycles += player.entity_data.stats.get_property(InitPropProviders.LUCK).get_luck() * _bonus_cycles
	for c in range(cycles):
		var chosen_output = _pick_weighted_output()
		if chosen_output.is_empty(): continue
		var count = randi_range(
			chosen_output['count']['min'],
			chosen_output['count']['max']
		)
		var item: BaseItem = chosen_output['item'].get_registered()
		if item:
			var stack := ItemStack.new(item, count)
			outputs.append(stack)
	return outputs


func _pick_weighted_output() -> Dictionary:
	if _possible_outputs.is_empty(): return {}
	var total_weight: float = 0
	for output in _possible_outputs:
		total_weight += output['weight']
	var rand_value: float = randf() * total_weight
	var cumulative: float = 0
	for output in _possible_outputs:
		cumulative += output['weight']
		if rand_value <= cumulative: return output
	return {}
