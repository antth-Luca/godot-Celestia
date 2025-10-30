extends BaseItem
class_name BaseRelic

var is_multiequip: bool = false

# SUPER
# Godot
func _init():
	max_stack = 1

# Getters and Setters
static func get_static_comparable_name() -> String:
	return 'BaseArmor'


func get_comparable_name() -> String:
	return BaseArmor.get_static_comparable_name()

# Handlers
func can_equip(slot: BaseSlot) -> bool:
	var slot_type = slot.slot_type
	if not (slot_type in [
		BaseSlot.Type.GENERIC,
		BaseSlot.Type.INPUT,
		BaseSlot.Type.RELIC
	]): return false
	if is_multiequip: return true
	return not slot.player.inventory.has_relic(self)
