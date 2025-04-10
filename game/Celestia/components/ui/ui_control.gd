extends CanvasLayer


func _input(event):
	if event.is_action_pressed("ui_inventory"):
		var inventory = $FullInventory
		inventory.visible = !inventory.visible
		if !inventory.visible:
			inventory.get_node("BackpackSlots").on_inventory_closed()
