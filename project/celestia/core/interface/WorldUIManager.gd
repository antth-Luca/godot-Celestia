extends CanvasLayer

signal ui_rotate_pressed

@onready var Hud := $HUD
@onready var BgBlur := $Panel
@onready var MyPanel := $MyPanel

# GODOT
func _ready():
	BgBlur.visible = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_rotate') and !BgBlur.visible:
		emit_signal('ui_rotate_pressed')
	elif event.is_action_pressed("ui_inventory"):
		update_my_panel(MyPanel.visible)
	elif event.is_action_pressed("ui_cancel") and BgBlur.visible:
		update_my_panel(true)

# GETTERS AND SETTERS
# Nodes
func get_player():
	return get_parent()


func get_hud():
	return get_node('HUD')


func get_invent_panel():
	return get_node('MyPanel')

# HANDLERS
func update_my_panel(current_switch: bool) -> void:
	BgBlur.visible = !current_switch
	MyPanel.visible = !current_switch
