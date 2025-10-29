extends BaseEnchantment
class_name FightingSpiritEnchantment

const DAMAGE_BUFF_PERCENTAGE: float = .15
const ACTIVE_AND_CD_TIME: float = 6
const RESET_TIME: float = 2.5

var hit_counter: int
var timer: Timer
var is_active: bool = false

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
func post_damage(hit: HitData, _target: LivingEntity) -> void:
	if is_active: return
	# Init Timer
	if not timer:
		timer = Timer.new()
		timer.timeout.connect(_on_timer_timeout)
		hit.attacker.add_child(timer)
	# Enchantment manager
	hit_counter += 1
	if not hit_counter < 3:
		is_active = true
		timer.start(ACTIVE_AND_CD_TIME)
		return
	timer.start(RESET_TIME)


func get_additional_damage_factor(_source_stats: PropertyManager, _target_stats: PropertyManager) -> float:
	if is_active: return DAMAGE_BUFF_PERCENTAGE
	return 0

# HANDLERS
func _on_timer_timeout() -> void:
	hit_counter = 0
	if is_active: is_active = false
