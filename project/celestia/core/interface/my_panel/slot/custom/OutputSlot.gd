extends BaseSlot
class_name OutputSlot

signal slot_item_added()
signal slot_item_removed()

const RESULT_COLOR := Color(Color.WHITE, 1)
const PREVIEW_COLOR := Color(Color.WHITE, .5)

# SUPER
# Handlers
func render_slot() -> void:
	super.render_slot()
	itemSprite.modulate = RESULT_COLOR
	itemAmount.modulate = RESULT_COLOR
	emit_signal('slot_item_added')


func clear_slot() -> void:
	super.clear_slot()
	emit_signal('slot_item_removed')

# MAIN
func set_output_preview(stack_preview: ItemStack) -> void:
	slotTypeSprite.visible = false
	itemSprite.texture = load(Celestia.ITEM_SPRITE_PATH % stack_preview.item.id.get_splited())
	itemSprite.visible = true
	if stack_preview.amount > 1:
		itemAmount.text = str(stack_preview.amount)
		itemAmount.visible = true
	else:
		itemAmount.visible = false
	itemSprite.modulate = PREVIEW_COLOR
	itemAmount.modulate = PREVIEW_COLOR
