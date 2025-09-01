extends RefCounted
class_name ItemStack

static var EMPTY = ItemStack.new(null, 0)

var item: BaseItem
var amount: int


func _init(item_param: BaseItem, amount_param: int = 1) -> void:
	item = item_param
	amount = amount_param


func add_amount_safe(amount_safe: int) -> int:
	if amount_safe <= 0: return amount_safe
	var space_left = item.max_stack - amount
	var to_add = min(space_left, amount_safe)
	amount += to_add
	return amount_safe - to_add


func is_empty() -> bool:
	return self == EMPTY or self.amount <= 0
