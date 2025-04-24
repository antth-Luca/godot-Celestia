extends PopupPanel


@onready var label_name = $VBoxContainer/LabelName
@onready var label_rarity = $VBoxContainer/LabelRarity
@onready var label_type = $VBoxContainer/LabelType

func item_popup(slot: Rect2i, item: BaseItem):
	var mouse_pos = get_viewport().get_mouse_position()
	var correction
	var padding = 4

	if mouse_pos.x > get_visible_rect().size.x / 2:
		correction = Vector2i(slot.size.x + padding, 0)
	else:
		correction = -Vector2i(self.size.x + padding, 0)

	self.popup(
		Rect2i(
			slot.position + correction,
			self.size
	))


func hide_popup():
	self.hide()


func update_data_popup(item: BaseItem):
	label_name.text = CustomTr.t('item.' + item.item_key + '.name')
	#label_rarity.text = CustomTr.t('item.rarity.' + item.item_key)
	#label_type.text = CustomTr.t('item.type.' + item.item_key)
