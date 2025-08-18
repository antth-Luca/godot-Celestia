extends RefCounted
class_name CursorManager

var _cursor_stack: ItemStack = ItemStack.EMPTY
var _cursor_click_origin_slot: int
var _cursor_sprite: Sprite2D = null

# GETTERS AND SETTERS
func get_cursor_stack() -> ItemStack:
	return _cursor_stack


func set_cursor_stack(new_stack: ItemStack) -> void:
	if new_stack == null or new_stack.get_item() == null or new_stack.get_amount() <= 0:
		return
	_cursor_stack = new_stack


func get_cursor_click_origin_slot() -> int:
	return _cursor_click_origin_slot


func set_cursor_click_origin_slot(slot_index: int) -> void:
	if slot_index < 0 or slot_index > 46:
		return
	_cursor_click_origin_slot = slot_index


func set_cursor_sprite(splited_id: Array, inventory: Control):
	if _cursor_sprite == null:
		_cursor_sprite = Sprite2D.new()
		inventory.add_child(_cursor_sprite)
	_cursor_sprite.texture = load('res://assets/%s/textures/items/%s.png' % splited_id)
	_cursor_sprite.global_position = inventory.get_global_mouse_position()

# HANDLERS
func set_click(new_stack: ItemStack, slot_index: int, inventory: Control) -> void:
	set_cursor_stack(new_stack)
	set_cursor_click_origin_slot(slot_index)
	set_cursor_sprite(new_stack.get_item().get_splited_id(), inventory)


func clear_cursor() -> void:
	_cursor_stack = ItemStack.EMPTY
	clear_cursor_sprite()


func is_cursor_stack_empty() -> bool:
	return _cursor_stack.get_amount() <= 0


func is_equal_to(stack: ItemStack) -> bool:
	return _cursor_stack.get_item().get_id() == stack.get_item().get_id()

func clear_cursor_sprite() -> void:
	if _cursor_sprite == null:
		return
	_cursor_sprite.queue_free()
	_cursor_sprite = null


func update_cursor_sprite_position(mouse_position: Vector2):
	_cursor_sprite.global_position = mouse_position
