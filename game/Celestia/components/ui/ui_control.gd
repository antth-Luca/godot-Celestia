extends CanvasLayer


func _input(event):
	if event.is_action_pressed("ui_inventory"):
		var inventory = $FullInventory
		inventory.visible = !inventory.visible
