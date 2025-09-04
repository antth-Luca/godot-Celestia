extends CanvasLayer
class_name WorldUI

signal ui_rotate_pressed

@onready var hud: PlayerHUD = $HUD
@onready var bg_blur := $Panel
@onready var my_panel: MyPanel = $MyPanel

# GODOT
func _ready():
	bg_blur.visible = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_rotate') and !bg_blur.visible:
		emit_signal('ui_rotate_pressed')
	elif event.is_action_pressed("ui_inventory"):
		update_my_panel(my_panel.visible)
	elif event.is_action_pressed("ui_cancel") and bg_blur.visible:
		update_my_panel(true)

# GETTERS AND SETTERS
# Nodes
func get_player() -> Player:
	return get_parent()


func get_hud() -> PlayerHUD:
	return get_node('HUD')


func get_invent_panel() -> MyPanel:
	return get_node('MyPanel')

# HANDLERS
func update_my_panel(current_switch: bool) -> void:
	bg_blur.visible = !current_switch
	my_panel.visible = !current_switch
