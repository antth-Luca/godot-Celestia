extends BaseItem
class_name BaseFood

var satiation: float = 1:
	set(new_sat):
		satiation = max(new_sat, 0)
var regen_hp: float = 0:
	set(new_regen):
		regen_hp = max(new_regen, 0)

# SUPER
func use(player: Player) -> void:
	var hungry_prop: HungryProperty = player.entity_data.stats.get_property(InitPropProviders.HUNGRY)
	if hungry_prop.get_hungry() < hungry_prop.get_max_hungry():
		hungry_prop.add_hungry(satiation)
		if regen_hp > 0: player.heal(regen_hp)
		var hand_slot: Slot = player.inventory.get_hand()
		var stack: ItemStack = hand_slot.stack
		stack.amount -= 1
		if stack.amount <= 0:
			break_item(hand_slot)
		else:
			hand_slot.render_slot()
		
