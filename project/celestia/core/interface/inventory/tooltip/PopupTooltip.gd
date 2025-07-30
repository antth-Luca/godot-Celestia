extends Control

@onready var popup_panel: PopupPanel = $CanvasLayer/PopupPanel
@onready var title_label: Label = $CanvasLayer/PopupPanel/MarginContainer/VBoxContainer/TitleLabel
@onready var tooltip_label: Label = $CanvasLayer/PopupPanel/MarginContainer/VBoxContainer/TooltipLabel


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
	title_label.text = CustomTranslation.t('item.' + item.item_key + '.name') + " (" + CustomTranslation.t('item.rarity.' + Rarity.get_name(item.rarity)) + ")"
	title_label.label_settings.font_color = Rarity.get_color(item.rarity)
	tooltip_label.text = CustomTranslation.t('item.' + item.item_key + '.tooltip')
