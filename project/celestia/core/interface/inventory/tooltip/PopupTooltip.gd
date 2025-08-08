extends Control

@onready var INVENTORY = get_parent()
@onready var CURSOR: CursorManager = INVENTORY.cursor
@onready var popup_panel: PopupPanel = $CanvasLayer/PopupPanel
@onready var title_label: RichTextLabel = $CanvasLayer/PopupPanel/MarginContainer/VBoxContainer/TitleRichLabel
@onready var tooltip_label: RichTextLabel = $CanvasLayer/PopupPanel/MarginContainer/VBoxContainer/TooltipRichLabel


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
	title_label.clear()
	tooltip_label.clear()
	var tooltip_lines: Array[String] = item.get_tooltip()
	title_label.append_text(tooltip_lines[0])
	if tooltip_lines.size() > 1:
		tooltip_label.visible = true
		for c in range(1, tooltip_lines.size()):
			tooltip_label.append_text(tooltip_lines[c])
	else:
		tooltip_label.visible = false

# HANDLERS
func _handle_entered_mouse_on_slot(slot: Slot):
	if CURSOR.is_cursor_stack_empty():
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
	if CURSOR.is_cursor_stack_empty():
		hide_popup()
