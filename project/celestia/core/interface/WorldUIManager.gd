extends CanvasLayer
class_name WorldUI

signal ui_rotate_pressed

@onready var hud: PlayerHUD = $HUD
@onready var bg_blur := $Panel
@onready var my_panel: MyPanel = $MyPanel

var player: Player

# GODOT
func _ready():
	bg_blur.visible = false


func _input(event: InputEvent) -> void:
	if !bg_blur.visible:
		if event.is_action_pressed('ui_use'):
			player.perform_use_item_hand()
		elif event.is_action_pressed('ui_rotate'):
			emit_signal('ui_rotate_pressed')
		elif event.is_action_pressed("ui_inventory"):
			update_my_panel(my_panel.visible)
	else:
		if event.is_action_pressed('ui_cancel'):
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
