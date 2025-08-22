extends Control

@onready var inventory_tab = $InventoryTab
@onready var stats_tab = $StatsTab

# GODOT
func _ready() -> void:
	visible = false
	_show_inventory()


func _input(event):
	if self.visible:
		if event.is_action_pressed("ui_tab_1"):
			_on_inventory_button_pressed()
		elif event.is_action_pressed("ui_tab_2"):
			_on_stats_button_pressed()
	else:
			inventory_tab._on_inventory_closed()


func _on_inventory_button_pressed():
	_show_inventory()


func _on_stats_button_pressed():
	stats_tab.update_data_to_stats()
	_show_stats()

# GETTERS AND SETTERS
# Nodes
func get_ui():
	return get_parent()


func get_inventory_tab():
	return get_node('InventoryTab')


func get_stats_tab():
	return get_node('StatsTab')

# HANDLERS
func _show_inventory() -> void:
	stats_tab.visible = false
	inventory_tab.visible = true


func _show_stats() -> void:
	inventory_tab.visible = false
	stats_tab.visible = true
