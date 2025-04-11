extends Sprite2D

var stack: ItemStack


func initialize(stack_param: ItemStack):
	self.stack = stack_param
	texture = load("res://assets/textures/items/" + stack.item_class.icon_name + ".png")


func _on_body_entered(body):
	if body.is_in_group("player"):
		var inventory = body.get_node("UI/FullInventory/BackpackSlots")
		if !inventory.is_full():
			var follow_tween = create_tween()
			follow_tween.tween_property(
				self,
				"position",
				body.global_position,
				0.1
			)
			await follow_tween.finished
			inventory.add_item_to_invent(stack)
			queue_free()
