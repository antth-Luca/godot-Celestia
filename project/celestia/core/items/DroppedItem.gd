extends Area2D
class_name DroppedItem

var stack: ItemStack


func initialize(stack_param: ItemStack):
	stack = stack_param
	$ItemSprite.texture = load("res://assets/textures/items/" + stack.item_id + ".png")


func _on_body_entered(body):
	if body.is_in_group("player"):
		var inventory = body.get_node("UI/Inventory")
		if not inventory.is_full():
			var follow_tween = create_tween()
			follow_tween.tween_property(
				self,
				"position",
				body.global_position,
				0.1
			)
			await follow_tween.finished
			inventory.add_item_to_backpack(stack)
			queue_free()
