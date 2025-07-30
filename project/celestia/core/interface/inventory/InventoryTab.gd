extends Control

@onready var slots_group = $SlotsGroup
@onready var popup_tooltip = $PopupTooltip

var inventory = []
var stack_in_cursor: ItemStack
var cursor_click_origin_slot: int
var sprite_to_cursor: Sprite2D = null


# Called when the node enters the scene tree for the first time.
func _ready():
	clear_inventory()


func clear_inventory() -> void:
	for c in slots_group.get_children():
		c.clear_slot()
