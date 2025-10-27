extends BaseTool
class_name FiringTool

var ammo_item: BaseAmmo
var min_ammo_to_fire: int

# SUPER
# Main
func use(player: Player) -> void:
	# Check if there is enough AMMO...
	var ammo_slots: Array[BaseSlot] = player.inventory.get_ammo_available()
	for slot in ammo_slots:
		var slot_stack: ItemStack = slot.stack
		if not slot_stack.is_empty() and (
			slot_stack.item.id.get_string() == ammo_item.id.get_string() and
			not slot_stack.amount < min_ammo_to_fire
		):
			var can_consume = true
			var hit_number: int = 1
			for enchant in enchantments:
				can_consume = enchant.check_consume_ammo()
				hit_number += enchant.get_additional_hit_number()
			for c in hit_number:
				# Shoot
				HitUtils.spawn_hit(player, hit_type, self)
				consume_durability(1, player.inventory.get_hand())
				# Consume available AMMO
				if can_consume:
					slot_stack.amount -= min_ammo_to_fire
					if slot_stack.amount <= 0:
						break_item(slot)
					else:
						slot.render_slot()
			set_cooldown(player)
			return

# Getters and Setters
static func get_static_comparable_name() -> String:
	return 'FiringTool'


func get_comparable_name() -> String:
	return FiringTool.get_static_comparable_name()

# Main
func copy(copy_obj: Variant = FiringTool.new()) -> Variant:
	copy_obj = super.copy(copy_obj)
	copy_obj.ammo_item = ammo_item
	copy_obj.min_ammo_to_fire = min_ammo_to_fire
	return copy_obj
