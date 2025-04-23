extends Control

@onready var inventory_tab = $"../InventoryTab"
@onready var stats_tab = $"../StatsTab"


func _ready():
	update_data_to_stats()
	show_inventory()


func update_data_to_stats():
	pass


func show_inventory():
	stats_tab.visible = false
	inventory_tab.visible = true


func show_stats():
	update_data_to_stats()
	inventory_tab.visible = false
	stats_tab.visible = true


func _on_stats_button_pressed():
	show_stats()


func _on_inventory_button_pressed():
	show_inventory()
