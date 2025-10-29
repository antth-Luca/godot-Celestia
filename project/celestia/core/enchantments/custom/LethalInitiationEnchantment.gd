extends BaseEnchantment
class_name LethalInitiationEnchantment

const REGEN_FACTOR: float = 1.4
const COOLDOWN_PER_TARGET: float = 8

var is_active: bool = false
var last_targets: Dictionary[LivingEntity, Timer]

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
func override_hitdata(hit: HitData, target: LivingEntity) -> HitData:
	for entity in last_targets.keys():
		if target == entity: return hit
	# Enable to regenerate
	is_active = true
	# Control cooldown
	var timer = create_timer_to_target(target)
	hit.attacker.add_child(timer)
	last_targets[target] = timer
	# Critical hit/damage
	hit.is_crit = true
	return hit


func post_damage(hit: HitData, _target: LivingEntity, final_damage: float) -> void:
	if not is_active: return
	is_active = false
	var attacker_hp_prop: HealthProperty = hit.attacker.entity_data.stats.get_property(InitPropProviders.HEALTH)
	attacker_hp_prop.add_health(final_damage * REGEN_FACTOR)

# MAIN
func create_timer_to_target(target: LivingEntity) -> Timer:
	var timer = Timer.new()
	timer.name = 'LethalInitEnchantTimer'
	timer.one_shot = true
	timer.autostart = true
	timer.wait_time = COOLDOWN_PER_TARGET
	timer.connect('timeout', Callable(self, '_on_timer_timeout').bind(target))
	return timer

# HANDLERS
func _on_timer_timeout(target: LivingEntity) -> void:
	last_targets[target].queue_free()
	last_targets.erase(target)
