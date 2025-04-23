extends CanvasLayer

@onready var inventory = $FullInventory


func _ready() -> void:
	inventory.visible = false


func _input(event):
	if event.is_action_pressed("ui_inventory"):
		inventory.visible = !inventory.visible
		if !inventory.visible:
			inventory.on_inventory_closed()
