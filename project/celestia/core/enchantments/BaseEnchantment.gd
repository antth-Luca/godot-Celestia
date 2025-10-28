extends Resource
class_name BaseEnchantment

var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('BaseEffect: Item ID already set. It cannot be changed after initialization.')
		id = new_id
var applicabilities: Array[String]
var incompabilities: Array[DeferredHolder]
var level: int:
	set(new_lv):
		if not level and new_lv < 1:
			push_warning('BaseEnchantment: The initial level value cannot be less than 1.')
		level = clamp(new_lv, 1, max_level)
var max_level: int:
	set(new_max):
		max_level = max(new_max, 1)

# GODOT
func _init(max_level_param: int, init_level: int, applicable_items: Array[String], incompatible_enchats: Array[DeferredHolder] = []) -> void:
	max_level = max_level_param
	level = init_level
	applicabilities = applicable_items
	incompabilities = incompatible_enchats

# MAIN
func check_applicability(to_apply: BaseItem) -> bool:
	var comparable: String = to_apply.get_comparable_name()
	return comparable in applicabilities


func check_compability(to_apply: BaseItem) -> bool:
	for incomp in incompabilities:
		for enchant in to_apply.enchantments:
			if incomp.location.get_string() == enchant.id.get_string():
				return false
	return true

# HOOKS
## Called by BaseTool#use and the value obtained is added to loop number to spawn hits.
func get_additional_hit_number() -> int: return 0

## Called by BaseHit#initialize and the value obtained is added to the hit's speed factor.
func get_additional_hit_speed() -> float: return 0

## Called by BaseHit#set_lifespan and the value obtained is added to entity's range.
func get_additional_range() -> float: return 0

## Called by BaseHit#_on_hurt_entity. Through independent logic, it returns true or false, allowing or not allowing the despawn of hit.
func override_can_despawn_hit(can_despawn: bool) -> bool: return can_despawn

## Called by FiringTool#use. Through independent logic, it returns true or false, allowing or not allowing the consumption of the entity's ammo.
func override_can_consume_ammo(can_consume: bool) -> bool: return can_consume

## Called by BaseItem#consume_durability. Through independent logic, it returns true or false, allowing or not allowing the consumption of the item's durability.
func override_can_consume_durability(can_consume: bool) -> bool: return can_consume

## Called by DamageManager#try_apply, immediately after damage is applied.
func post_damage(_hit: HitData, _target: LivingEntity) -> void: pass

## Called by DamageManager#try_apply right at the beginning to override the HitData obtained.
func override_hitdata(hit: HitData, _target: LivingEntity) -> HitData: return hit

## Called by LivingEntity#apply_knockback and the value obtained is added to the knockback factor.
func get_additional_knockback_factor() -> float: return 0

## Called by DamageManager#get_brute_damage and the value obtained is added to the item's damage factor.
func get_additional_damage_factor(_source_stats: PropertyManager, _target_stats: PropertyManager) -> float: return 0

## Called by DamageManager#compute_defense and the value obtained is added to the entity's resistance.
func get_additional_resistance() -> float: return 0

## Called by DamageManager#compute_defense and the value obtained is added to the entity's armor.
func get_additional_armor() -> float: return 0
