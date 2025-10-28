extends BaseEnchantment
class_name FaithlessDefense

var hit_counter: int
var last_target: LivingEntity

# SUPER
# Godot
func _init(init_level: int) -> void:
	super._init(1, init_level, [
		BaseTool.get_static_comparable_name(),
		AxeTool.get_static_comparable_name(),
		PickaxeTool.get_static_comparable_name(),
		SwordTool.get_static_comparable_name(),
		FiringTool.get_static_comparable_name()
	])

# Hooks
func post_damage(_hit: HitData, target: LivingEntity) -> void:
	if target == last_target:
		hit_counter += 1
		return
	last_target = target
	hit_counter = 1


func override_hitdata(hit: HitData, _target: LivingEntity) -> HitData:
	if not hit_counter < 2:
		hit.primitive_type = HitData.PRIMITIVE_TYPE.TRUE
		hit_counter = -1
	print(hit.primitive_type)
	return hit
