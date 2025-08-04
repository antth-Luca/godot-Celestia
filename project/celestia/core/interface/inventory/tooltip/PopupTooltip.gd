extends Control

@onready var INVENTORY = get_parent()
@onready var popup_panel: PopupPanel = $CanvasLayer/PopupPanel
@onready var title_label: Label = $CanvasLayer/PopupPanel/MarginContainer/VBoxContainer/TitleLabel
@onready var tooltip_label: Label = $CanvasLayer/PopupPanel/MarginContainer/VBoxContainer/TooltipLabel


func _ready():
	EventBus.client_inventory.connect('mouse_entered_slot', Callable(self, '_handle_entered_mouse_on_slot'))
	EventBus.client_inventory.connect('mouse_exited_slot', Callable(self, '_handle_exited_mouse_on_slot'))


func item_popup(slot: Rect2i, item: BaseItem):
	var mouse_pos = get_viewport().get_mouse_position()
	var correction

	update_data_popup(item)
	popup_panel.size = Vector2i.ZERO

	if mouse_pos.x <= get_viewport_rect().size.x / 2:
		correction = Vector2i((slot.size.x * 2) + 10, 8)
	else:
		correction = -Vector2i(popup_panel.size.x, -8)

	popup_panel.popup(
		Rect2i(
			slot.position + correction,
			popup_panel.size
	))


func hide_popup():
	popup_panel.hide()


func update_data_popup(item: BaseItem):
	title_label.text = '%s (%s)' % [
		CustomTranslation.t('item.%s.name' % [item.get_splited_id()[1]]),
		Rarity.get_name(item.get_rarity())
	]
	title_label.label_settings.font_color = Rarity.get_color(item.get_rarity())
	tooltip_label.text = CustomTranslation.t('item.' + item.get_splited_id()[1] + '.tooltip')

# HANDLERS
func _handle_entered_mouse_on_slot(slot):
	if INVENTORY.get_stack_in_cursor() == null:
		var slot_stack = INVENTORY.get_stack_in_inventory(slot.get_index())
		if slot_stack.get_amount() > 0:
			item_popup(
				Rect2i(
					Vector2i(slot.global_position),
					Vector2i(slot.size)
				),
				slot_stack.get_item()
			)


func _handle_exited_mouse_on_slot():
	if INVENTORY.get_stack_in_cursor() == null:
		hide_popup()
