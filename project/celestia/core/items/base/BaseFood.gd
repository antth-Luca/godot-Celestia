extends BaseItem
class_name BaseFood

var satiation: float = 1:
	set(new_sat):
		satiation = max(new_sat, 0)

# SUPER
func use(player: Player) -> void:
	var hungry_prop: HungryProperty = player.entity_data.stats.get_property(InitPropProviders.HUNGRY)
	if hungry_prop.get_hungry() < hungry_prop.get_max_hungry():
		hungry_prop.add_hungry(satiation)
		var stack: ItemStack = player.inventory.inventory[player.inventory.selected]
		stack.amount -= 1
		if stack.amount <= 0: stack = ItemStack.EMPTY
		player.inventory.get_slot(player.inventory.selected).render_slot(stack)
		
