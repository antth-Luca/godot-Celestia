extends Resource
class_name BaseEnchantment

var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('BaseEffect: Item ID already set. It cannot be changed after initialization.')
		id = new_id
var applicabilities: Array[String]
var incompabilities: Array[DeferredHolder]
var level: int:
	set(new_lv):
		if not level and new_lv < 1:
			push_warning('BaseEnchantment: The initial level value cannot be less than 1.')
		level = clamp(new_lv, 1, max_level)
var max_level: int:
	set(new_max):
		max_level = max(new_max, 1)

# MAIN
func check_applicability(to_apply: BaseItem) -> bool:
	var comparable: String = to_apply.COMPARABLE_NAME
	return comparable and comparable in applicabilities


func check_compability(to_apply: ItemStack) -> bool:
	for incomp in incompabilities:
		for enchant in to_apply.enchantments:
			if incomp.location.get_string() == enchant.id.get_string():
				return false
	return true

# HOOKS
# 
