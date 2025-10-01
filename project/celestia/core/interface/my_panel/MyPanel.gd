extends Control
class_name MyPanel

@onready var cursor = $PanelCursor
@onready var popup_tooltip: PopupTooltip = $PopupTooltip
@onready var inventory_tab: InventoryManager = $InventoryTab
@onready var stats_tab: StatsManager = $StatsTab
@onready var craft_tab: CraftManager = $CraftTab

var selected_tab: int = 0:
	set(new_selected):
		var buttons_count: int = tab_buttons.size() - 1
		if new_selected < 0:
			selected_tab = buttons_count
			return
		if new_selected > buttons_count:
			selected_tab = 0
			return
		selected_tab = new_selected
var tab_buttons: Array[TextureButton] = []

# GODOT
func _ready() -> void:
	# Fill childrens
	var player: Player = get_parent().get_parent()
	inventory_tab.player = player
	stats_tab.player_stats = player.entity_data.stats
	# Variables
	for btn in get_node('Background/TabButtons').get_children():
		tab_buttons.append(btn)
	# Visibility
	visible = false
	_on_inventory_tab_button_pressed()


func _input(event):
	if self.visible:
		if event.is_action_pressed("ui_left"):
			selected_tab -= 1
			tab_buttons[selected_tab].emit_signal('pressed')
		elif event.is_action_pressed("ui_right"):
			selected_tab += 1
			tab_buttons[selected_tab].emit_signal('pressed')
	else:
			_on_panel_closed()

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


func get_cursor() -> PanelCursor:
	return get_node('PanelCursor')


func get_popup_tooltip() -> PopupTooltip:
	return get_node('PopupTooltip')

# HANDLERS
func _on_panel_closed() -> void:
	if not cursor.stack.is_empty():
		inventory_tab.add_item_to_backpack(cursor.stack)
		cursor.stack = ItemStack.EMPTY


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
