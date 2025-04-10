extends Node
class_name ItemStack

var item_class: BaseItem
var amount: int


func _init(item: BaseItem, amount_slot: int):
	self.item_class = item
	self.amount = amount_slot


static func get_empty_slot() -> ItemStack:
	return ItemStack.new(BaseItem.get_empty_item(), 0)
