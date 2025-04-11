extends Node
class_name ItemStack

var item_class: BaseItem
var amount: int


func _init(item: BaseItem, amount_slot: int):
	self.item_class = item
	self.amount = amount_slot


static func get_empty_slot() -> ItemStack:
	return ItemStack.new(BaseItem.get_empty_item(), 0)


func add_amount_safe(amount_safe: int) -> int:
	if amount_safe > 0:
		var space_left = item_class.max_stack - amount
		var to_add = min(space_left, amount_safe)
		amount += to_add
		return amount_safe - to_add
	return amount_safe
