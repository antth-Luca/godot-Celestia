extends BaseItem
class_name BaseRelic

var is_multiequip: bool = false
var incompabilities: Array[DeferredHolder]

# SUPER
# Godot
func _init():
	max_stack = 1

# Getters and Setters
static func get_static_comparable_name() -> String:
	return 'BaseRelic'


func get_comparable_name() -> String:
	return BaseRelic.get_static_comparable_name()


func get_tooltip() -> Array[String]:
	var lines: Array[String] = super.get_tooltip()
	lines.insert(2, '[color=%s]%s %s:[/color]\n' % [
		COMMON_TEXT_COLOR,
		tr(Celestia.TRANSLATION_KEY_BASES.SECTION_TITLE % 'when_slot'),
		tr(Celestia.TRANSLATION_KEY_BASES.SLOT % BaseSlot.Type.RELIC)
	])
	return lines

# Main
func copy(copy_obj: Variant = BaseRelic.new()) -> Variant:
	copy_obj = super.copy(copy_obj)
	copy_obj.is_multiequip = is_multiequip
	copy_obj.incompabilities = incompabilities
	return copy_obj

# Handlers
func can_equip(slot: BaseSlot) -> bool:
	var slot_type = slot.slot_type
	if not (slot_type in [
		BaseSlot.Type.GENERIC,
		BaseSlot.Type.INPUT,
		BaseSlot.Type.RELIC
	]): return false
	if is_multiequip: return true
	return not slot.player.inventory.has_relic(incompabilities)


func use(player: Player) -> void:
	var relic_slots: Array[BaseSlot] = player.inventory.get_relics()
	for slot in relic_slots:
		if slot.stack.is_empty():
			if can_equip(slot):
				var hand_slot: BaseSlot = player.inventory.get_hand()
				hand_slot.stack.item.on_unequip(hand_slot, player)
				slot.stack = hand_slot.stack
				slot.stack.item.on_equip(slot, player)
				hand_slot.stack = ItemStack.EMPTY
			break

# HOOKS
## Called by InventoryManager#_process.
func on_tick(_equipped_entity: LivingEntity, _delta: float) -> void: pass

## Called by InventoryManager#_physics_process.
func on_physic_tick(_equipped_entity: LivingEntity, _delta: float) -> void: pass

## Called by DamageManager#try_apply, immediately after final damage is calculated.
func override_can_apply_damage(_hit: HitData, _target: LivingEntity, _final_damage: float, can_damage: bool) -> bool: return can_damage

## Called by DamageManager#try_apply, immediately after damage is applied.
func post_damage(_hit: HitData, _target: LivingEntity, _final_damage: float) -> void: pass

## Called by DamageManager#try_apply, immediately after damage is applied.
func post_hurt(_hit: HitData, _target: LivingEntity, _final_damage: float) -> void: pass

## Called by LivingEntity#heal, immediately after heal is applied.
func post_heal(_healed_entity: LivingEntity, _heal_value: float) -> void: pass

## Called by Player#add_survivor_exp, immediately after experience is added.
func post_surv_exp_added(_added_entity: LivingEntity, _exp_value: float) -> void: pass
