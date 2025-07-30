extends Control

@onready var inventory_tab = $InventoryTab
@onready var stats_tab = $StatsTab

var inventory = []
var stack_in_cursor: ItemStack
var cursor_click_origin_slot: int
var sprite_to_cursor: Sprite2D = null

func _ready() -> void:
	visible = false
	show_inventory()


func _input(event):
	if event.is_action_pressed("ui_inventory"):
		self.visible = !self.visible
	elif event.is_action_pressed("ui_cancel") and self.visible:
		self.visible = false

	if self.visible:
		if event.is_action_pressed("ui_tab_1"):
			_on_inventory_button_pressed()
		elif event.is_action_pressed("ui_tab_2"):
			_on_stats_button_pressed()
	# else:
			# on_inventory_closed()


func show_inventory() -> void:
	stats_tab.visible = false
	inventory_tab.visible = true


func show_stats() -> void:
	inventory_tab.visible = false
	stats_tab.visible = true


func _on_inventory_button_pressed():
	show_inventory()


func _on_stats_button_pressed():
	stats_tab.update_data_to_stats()
	show_stats()
