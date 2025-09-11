extends Area2D
class_name DroppedItem

var stack: ItemStack
var can_collect: bool = true


func initialize(_stack_param: ItemStack):
	stack = _stack_param
	var id_parts: Array = stack.item.id.get_splited()
	$ItemSprite.texture = load(Celestia.ITEM_SPRITE_PATH % id_parts)


func set_delay_to_collect():
	can_collect = false
	var timer := Timer.new()
	timer.wait_time = 1
	timer.one_shot = true
	timer.connect(
		'timeout',
		func():
			can_collect = true
			timer.queue_free()
	)
	add_child(timer)
	timer.start()


func _on_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group('player') and can_collect:
		var inventory = body.get_ui().get_invent_panel().get_inventory_tab()
		if not inventory.get_stackable_index(stack.item.id) < 0:
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
