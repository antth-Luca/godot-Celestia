extends Node
class_name BaseItem

enum Rarity { COMMON, RARE, EPIC, MITHIC, LEGENDARY }

var item_key: String
var max_stack: int
var rarity: Rarity

func _init(key: String, enum_rarity: Rarity, num_stack: int) -> void:
	self.item_key = key
	self.max_stack = num_stack
	self.rarity = enum_rarity


func get_rarity_name() -> String:
	return Rarity.keys()[self.rarity]


static func get_empty_item() -> BaseItem:
	return BaseItem.new('', Rarity.COMMON, 99)
