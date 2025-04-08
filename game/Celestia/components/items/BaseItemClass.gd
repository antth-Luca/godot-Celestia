extends Node
class_name BaseItem

enum item_types {
	empty,
	consumible,
	tool
}

var item_name: String
var icon_name: String
var stackable: bool
var amount: int
var type: int
var use: Callable

func _init(item_name: String, icon_name: String, stackable: bool, amount: int, type: int, use: Callable) -> void:
	self.item_name = item_name
	self.icon_name = icon_name
	self.stackable = stackable
	self.amount = amount
	self.type = type
	self.use = use


func get_dict() -> Dictionary:
	return {
		'item_name': item_name,
		'icon_name': icon_name,
		'stackable': stackable,
		'amount': amount,
		'type': type,
		'use': use
	}


static func get_empty_item() -> BaseItem:
	return BaseItem.new('blank', '', false, 0, BaseItem.item_types.empty, Callable())
