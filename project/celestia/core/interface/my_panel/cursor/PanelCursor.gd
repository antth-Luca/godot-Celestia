extends Node2D
class_name PanelCursor

@onready var cursor_sprite = $Sprite

var stack: ItemStack = ItemStack.EMPTY:
	set(new_stack):
		if new_stack == null: return
		stack = new_stack
		if stack.is_empty():
			clear_cursor()
		else:
			render_cursor()

# GODOT
func _input(event):
	if event is InputEventMouseMotion:
		update_cursor_sprite_position()

# MAIN
func render_cursor() -> void:
	cursor_sprite.texture = load(Celestia.ITEM_SPRITE_PATH % stack.item.id.get_splited())
	update_cursor_sprite_position()


func clear_cursor() -> void:
	cursor_sprite.texture = null


func update_cursor_sprite_position():
	if not stack.is_empty():
		var mouse_position: Vector2 = get_global_mouse_position()
		cursor_sprite.global_position = mouse_position
