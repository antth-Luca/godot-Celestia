extends Node
class_name BaseItem

enum Rarity { COMMON, RARE, EPIC, MITHIC, LEGENDARY }

const RARITY_COLORS = {
	Rarity.COMMON: '#ffffff',
	Rarity.RARE: '#3dd63a',
	Rarity.EPIC: '#6c44d2',
	Rarity.MITHIC: '#db375b',
	Rarity.LEGENDARY: '#f9c600'
}

var item_key: String
var max_stack: int
var rarity: Rarity

func _init(key: String, enum_rarity: Rarity, num_stack: int) -> void:
	self.item_key = key
	self.max_stack = num_stack
	self.rarity = enum_rarity


func get_rarity_name(enum_rarity: Rarity = self.rarity) -> String:
	return Rarity.keys()[enum_rarity]


func get_rarity_color(enum_rarity: Rarity = self.rarity) -> Color:
	return Color(RARITY_COLORS[enum_rarity])


static func get_empty_item() -> BaseItem:
	return BaseItem.new('', Rarity.COMMON, 99)
