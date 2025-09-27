extends Control
class_name MyPanel

@onready var inventory_tab: InventoryManager = $InventoryTab
@onready var stats_tab: StatsManager = $StatsTab
@onready var craft_tab: CraftManager = $CraftTab

var selected_tab: int
var tab_buttons: Array[TextureButton] = []

# GODOT
func _ready() -> void:
	# Variables
	for btn in get_node('Background/TabButtons').get_children():
		tab_buttons.append(btn)
	# Node control
	visible = false
	_on_inventory_tab_button_pressed()
	selected_tab = 0


func _input(event):
	if self.visible:
		if event.is_action_pressed("ui_left"):
			selected_tab -= 1
			if selected_tab < 0: selected_tab = tab_buttons.size() - 1
			tab_buttons[selected_tab].emit_signal('pressed')
		elif event.is_action_pressed("ui_right"):
			selected_tab += 1
			if selected_tab > tab_buttons.size() -1: selected_tab = 0
			tab_buttons[selected_tab].emit_signal('pressed')
	else:
			inventory_tab._on_inventory_closed()

# GETTERS AND SETTERS
# Nodes
func get_ui() -> WorldUI:
	return get_parent()


func get_inventory_tab() -> InventoryManager:
	return get_node('InventoryTab')


func get_stats_tab() -> StatsManager:
	return get_node('StatsTab')


func get_craft_tab() -> CraftManager:
	return get_node('CraftTab')

# HANDLERS
func _on_inventory_tab_button_pressed():
	stats_tab.switch_visible_stats_tab(false)
	craft_tab.hide_all_workstations()
	inventory_tab.switch_visible_all_inventory(true)


func _on_stats_tab_button_pressed():
	inventory_tab.switch_visible_all_inventory(false)
	craft_tab.hide_all_workstations()
	stats_tab.switch_visible_stats_tab(true)


func _on_craft_tab_button_pressed():
	inventory_tab.switch_visible_all_inventory(false)
	inventory_tab.switch_visible_down_inventory(true)
	stats_tab.switch_visible_stats_tab(false)
	craft_tab.show_workstation(WorkstationTypes.MANUAL)
