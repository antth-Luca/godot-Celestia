extends Resource
class_name BaseItem

const AnimType: Dictionary = {
	USE = 'use',
	HOLD = 'hold'
}
const COMMON_TEXT_COLOR: String = '#8d8d8d'

var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('BaseItem: Item ID already set. It cannot be changed after initialization.')
		id = new_id
var max_stack: int = 99:
	set(new_stack):
		if _durability != 0: return
		max_stack = new_stack
var _max_durability: int = 0:
	set(new_max):
		_max_durability = max(new_max, 1)
var _durability: int = 0:
	set(new_durability):
		_durability = clamp(new_durability, 0, _max_durability)
var material: BaseMaterial = InitMaterials.GENERIC.get_registered()
var rarity: BaseRarity = InitRarities.COMMON.get_registered()
var anim_type: String = AnimType.HOLD
var use_speed_factor: float = 1
var in_cooldown: bool = false
var enchantments: Array[BaseEnchantment]

# GETTERS AND SETTERS
static func get_static_comparable_name() -> String:
	return 'BaseItem'


func get_comparable_name() -> String:
	return BaseItem.get_static_comparable_name()

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
	var new_durability = ceil(material.base_max_damage * durability_factor)
	_max_durability = new_durability
	_durability = new_durability
	max_stack = 1


func get_tooltip() -> Array[String]:
	var lines: Array[String] = []
	lines.append('%s [color=%s](%s)[/color]' % [
		tr(Celestia.TRANSLATION_KEY_BASES.ITEM % id.path),
		rarity.hex_color,
		rarity.get_tr_name()
	])
	if not enchantments.is_empty():
		var enchant_line = '[color=%s]%s:\n' % [
			COMMON_TEXT_COLOR,
			tr(Celestia.TRANSLATION_KEY_BASES.SECTION_TITLE % 'enchantment')
		]
		for enchant in enchantments:
			enchant_line += '  %s\n' % tr(Celestia.TRANSLATION_KEY_BASES.ENCHANTMENT % enchant.id.path)
		enchant_line += '[/color]'
		lines.append(enchant_line)
	if _durability != 0:
		lines.append('[color=%s]%s: %s / %s[/color]\n' % [
			COMMON_TEXT_COLOR,
			tr(Celestia.TRANSLATION_KEY_BASES.SECTION_TITLE % 'durability'),
			_durability, _max_durability
		])
	return lines

# MAIN
func copy(copy_obj: Variant = BaseItem.new()) -> Variant:
	copy_obj.id = id
	copy_obj.max_stack = max_stack
	copy_obj._max_durability = _max_durability
	copy_obj._durability = _durability
	copy_obj.material = material
	copy_obj.rarity = rarity
	copy_obj.anim_type = anim_type
	copy_obj.use_speed_factor = use_speed_factor
	copy_obj.in_cooldown = in_cooldown
	copy_obj.enchantments = enchantments.duplicate(true)
	return copy_obj


func add_enchantment(enchantment: BaseEnchantment) -> void:
	if not enchantment: return
	enchantments.append(enchantment)

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


func interact(_player: Player) -> void:
	pass


func consume_durability(damage: int, slot: BaseSlot) -> void:
	if _durability != 0 and damage != 0:
		var can_consume: bool = true
		for enchant in enchantments:
			can_consume = enchant.override_can_consume_durability(can_consume)
		if can_consume: _durability -= damage
		if _durability <= 0: break_item(slot)


func break_item(slot: BaseSlot) -> void:
	slot.stack = ItemStack.EMPTY
