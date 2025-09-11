extends RefCounted
class_name CursorManager

var inventory

var cursor_stack: ItemStack = ItemStack.EMPTY:
	set(new_stack):
		if new_stack == null:
			return
		cursor_stack = new_stack

var cursor_click_origin_slot: int:
	set(slot_index):
		if slot_index < inventory.MIN_SLOTS or slot_index > inventory.TOTAL_SLOTS:
			return
		cursor_click_origin_slot = slot_index

var _cursor_sprite: Sprite2D = null


func set_cursor_sprite(splited_id: Array):
	if _cursor_sprite == null:
		_cursor_sprite = Sprite2D.new()
		inventory.add_child(_cursor_sprite)
	_cursor_sprite.texture = load(Celestia.ITEM_SPRITE_PATH % splited_id)
	update_cursor_sprite_position(inventory.get_global_mouse_position())

# GODOT
func _init(inventory_node: Control):
	inventory = inventory_node

# HANDLERS
func set_click(new_stack: ItemStack, slot_index: int) -> void:
	cursor_stack = new_stack
	cursor_click_origin_slot = slot_index
	set_cursor_sprite(new_stack.item.id.get_splited())


func clear_cursor() -> void:
	cursor_stack = ItemStack.EMPTY
	clear_cursor_sprite()


func is_equal_to(stack: ItemStack) -> bool:
	return cursor_stack.item.id == stack.item.id


func clear_cursor_sprite() -> void:
	if _cursor_sprite == null:
		return
	_cursor_sprite.queue_free()
	_cursor_sprite = null


func update_cursor_sprite_position(mouse_position: Vector2):
	_cursor_sprite.global_position = mouse_position
