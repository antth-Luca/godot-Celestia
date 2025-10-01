extends Resource
class_name BaseItem

const AnimType: Dictionary = {
	USE = 'use',
	HOLD = 'hold'
}

var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('BaseItem: Item ID already set. It cannot be changed after initialization.')
		id = new_id
var max_stack: int = 99:
	set(new_stack):
		if _durability != 0: return
		max_stack = new_stack
var _durability: int = 0
var material: BaseMaterial = InitMaterials.GENERIC.get_registered()
var rarity: BaseRarity = InitRarities.COMMON.get_registered()
var anim_type: String = AnimType.HOLD
var use_speed_factor: float = 1
var in_cooldown: bool = false

# GETTERS AND SETTERS
# Cooldown
func set_cooldown(player: LivingEntity, cd_time: float = 0, can_reduce: bool = true) -> void:
	if cd_time == 0:
		cd_time = 1 / (player.entity_data.stats.get_property(InitPropProviders.USE_SPEED).get_use_speed() * use_speed_factor)
	elif can_reduce:
		cd_time *= player.entity_data.stats.get_property(InitPropProviders.COOLDOWN_REDUCTION).get_cooldown_reduction()
	in_cooldown = true
	await player.get_tree().create_timer(cd_time).timeout
	in_cooldown = false

# Variables
func set_durability(durability_factor: float = 1):
	_durability = ceil(material.base_max_damage * durability_factor)
	max_stack = 1


func get_tooltip() -> Array[String]:
	var name_line = '%s [color=%s](%s)[/color]' % [
		tr(Celestia.TRANSLATION_KEY_BASES.ITEM % id.path),
		rarity.hex_color,
		rarity.get_tr_name()
	]
	return [name_line]

# HANDLERS
func can_equip(slot: BaseSlot) -> bool:
	var slot_type = slot.slot_type
	return slot_type in [
		BaseSlot.Type.GENERIC,
		BaseSlot.Type.INPUT
	]


func on_equip(_slot: BaseSlot, _player: Player) -> void:
	pass


func can_unequip(_slot: BaseSlot) -> bool:
	return true


func on_unequip(_slot: BaseSlot, _player: Player):
	pass


func use(_player: Player) -> void:
	pass


func consome_durability(damage: int, slot: BaseSlot) -> void:
	if _durability != 0 and damage != 0:
		_durability -= damage
		if _durability <= 0: break_item(slot)


func break_item(slot: BaseSlot) -> void:
	slot.stack = ItemStack.EMPTY
