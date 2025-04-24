extends Control

@onready var popup_panel: PopupPanel = $CanvasLayer/PopupPanel
@onready var label_name: Label = $CanvasLayer/PopupPanel/MarginContainer/VBoxContainer/LabelName
@onready var label_rarity: Label = $CanvasLayer/PopupPanel/MarginContainer/VBoxContainer/LabelRarity


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
	label_name.text = CustomTr.t('item.' + item.item_key + '.name')
	label_rarity.text = CustomTr.t('item.rarity.' + item.get_rarity_name().to_lower())
	label_rarity.label_settings.font_color = item.get_rarity_color()
