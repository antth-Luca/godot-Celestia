extends Object
class_name ItemStack

var item_id: String
var amount: int


func _init(item_id: String, amount_slot: int):
	self.item_id = item_id
	self.amount = amount_slot


static func get_empty_slot() -> ItemStack:
	return ItemStack.new('', 1)


func add_amount_safe(amount_safe: int) -> int:
	if amount_safe > 0:
		var item_class = RegistryManager.ITEM_REGISTRY.get_entry(item_id)
		var space_left = item_class.max_stack - amount
		var to_add = min(space_left, amount_safe)
		amount += to_add
		return amount_safe - to_add
	return amount_safe
