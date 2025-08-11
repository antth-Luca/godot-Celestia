extends Area2D
class_name DroppedItem

var stack: ItemStack


func initialize(stack_param: ItemStack):
	stack = stack_param
	var id_parts: Array = stack.get_item().get_splited_id()
	$ItemSprite.texture = load('res://assets/%s/textures/items/%s.png' % id_parts)


func _on_body_entered(body):
	if body.is_in_group('player'):
		var inventory = body.get_node('WorldUI/MyPanel/InventoryTab')
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
