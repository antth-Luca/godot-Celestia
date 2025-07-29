extends Control

var inventory = []
var stack_in_cursor: ItemStack
var cursor_click_origin_slot: int
var sprite_to_cursor: Sprite2D = null

func _ready() -> void:
	visible = false


func _input(event):
	if event.is_action_pressed("ui_inventory"):
		self.visible = !self.visible
		# if !self.visible:
			# on_inventory_closed()
	elif event.is_action_pressed("ui_cancel") and self.visible:
		self.visible = false
		# on_inventory_closed()
