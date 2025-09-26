extends Control
class_name MyPanel

@onready var inventory_tab: InventoryManager = $InventoryTab
@onready var stats_tab: StatsManager = $StatsTab

var selected_tab: int
var tab_buttons: Array[TextureButton] = []

# GODOT
func _ready() -> void:
	# Variables
	for btn in get_node('Background/TabButtons').get_children():
		tab_buttons.append(btn)
	# Node control
	visible = false
	_show_inventory()
	selected_tab = 0


func _input(event):
	if self.visible:
		if event.is_action_pressed("ui_left"):
			selected_tab += 1
			if selected_tab > tab_buttons.size() -1: selected_tab = 0
			tab_buttons[selected_tab].emit_signal('pressed')
		elif event.is_action_pressed("ui_right"):
			selected_tab -= 1
			if selected_tab < 0: selected_tab = tab_buttons.size() - 1
			tab_buttons[selected_tab].emit_signal('pressed')
	else:
			inventory_tab._on_inventory_closed()


func _on_inventory_button_pressed():
	_show_inventory()


func _on_stats_button_pressed():
	stats_tab.update_data_to_stats()
	_show_stats()

# GETTERS AND SETTERS
# Nodes
func get_ui() -> WorldUI:
	return get_parent()


func get_inventory_tab() -> InventoryManager:
	return get_node('InventoryTab')


func get_stats_tab() -> StatsManager:
	return get_node('StatsTab')

# HANDLERS
func _show_inventory() -> void:
	stats_tab.visible = false
	inventory_tab.visible = true


func _show_stats() -> void:
	inventory_tab.visible = false
	stats_tab.visible = true
