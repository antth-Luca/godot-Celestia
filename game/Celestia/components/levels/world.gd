extends Node2D

const ABSTRACT_ITEM = preload("res://components/items/abstract_item.tscn")

func _ready() -> void:
	for c in range(2):
		var abstract_item = ABSTRACT_ITEM.instantiate()
		abstract_item.initialize(ItemStack.new(ChickenEgg.new(), 99))
		add_child(abstract_item)
