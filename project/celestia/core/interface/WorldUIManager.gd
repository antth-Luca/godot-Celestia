extends CanvasLayer
class_name WorldUI

signal ui_rotate_pressed

@onready var hud: PlayerHUD = $HUD
@onready var bg_blur := $Panel
@onready var my_panel: MyPanel = $MyPanel
@onready var view: ViewTransition = $ViewTransition
@onready var essence_vessel: EssenceVessel = $EssenceVessel
@onready var pause_menu := $PauseMenu

var player: Player

# GODOT
func _ready():
	# Signals
	pause_menu.get_node('VBoxContainer/ResumeButton').connect('pressed', Callable(self, '_on_resume_button_pressed'))
	pause_menu.get_node('VBoxContainer/QuitButton').connect('pressed', Callable(self, '_on_quit_button_pressed'))
	# Visible
	bg_blur.visible = false
	pause_menu.visible = false
	view.open_eyes()


func _input(event: InputEvent) -> void:
	# When there is NO open window...
	if !bg_blur.visible:
		if event.is_action_pressed('ui_use'):
			player.hand.perform_use()
		elif event.is_action_pressed('ui_interact'):
			player.hand.perform_interact()
		elif event.is_action_pressed('ui_rotate'):
			emit_signal('ui_rotate_pressed')
		elif event.is_action_pressed('ui_cancel'):
			update_pause_menu(false)
	# ...when there is
	elif event.is_action_pressed('ui_cancel'):
		update_my_panel(true)
		update_pause_menu(true)
	# Any case
	if not pause_menu.visible and event.is_action_pressed('ui_inventory'):
		update_my_panel(my_panel.visible)

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


func update_pause_menu(current_switch: bool) -> void:
	bg_blur.visible = !current_switch
	pause_menu.visible = !current_switch
	get_tree().paused = !current_switch


func _on_resume_button_pressed() -> void:
	update_pause_menu(true)


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file('res://client/screens/title_screen/TitleScreen.tscn')
