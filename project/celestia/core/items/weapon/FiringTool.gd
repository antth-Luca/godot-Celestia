extends BaseTool
class_name FiringTool

static var COMPARABLE_NAME = 'FiringTool'

var ammo_item: BaseAmmo
var min_ammo_to_fire: int

# SUPER
func use(player: Player) -> void:
	# Check if there is enough AMMO...
	var ammo_slots: Array[BaseSlot] = player.inventory.get_ammo_available()
	for slot in ammo_slots:
		var slot_stack: ItemStack = slot.stack
		if not slot_stack.is_empty() and (
			slot_stack.item.id.get_string() == ammo_item.id.get_string() or
			not slot_stack.amount < min_ammo_to_fire
		):
			super.use(player)  # Shoot
			# Consume available AMMO
			slot_stack.amount -= min_ammo_to_fire
			if slot_stack.amount <= 0:
				break_item(slot)
			else:
				slot.render_slot()
			break
