extends LivingEntity
class_name Player

# GODOT
func _init() -> void:
	entity_data = EntityData.new(
		EntityData.FACTION_MASK.PLAYER,
		PropertyManager.create_manager({
			InitPropProviders.SURVIVOR_LEVEL: 1,
			InitPropProviders.HEALTH: 100,
			InitPropProviders.ARMOR: 0,
			InitPropProviders.RESISTANCE: 0,
			InitPropProviders.DAMAGE_REDUCTION: 0,
			InitPropProviders.FORCE: 8,
			InitPropProviders.PENETRATION: 0,
			InitPropProviders.DEFENSE_REDUCTION: 0,
			InitPropProviders.CRITICAL_STRIKE: 0,
			InitPropProviders.LIFE_STEAL: 0,
			InitPropProviders.MANA: 50,
			InitPropProviders.RANGE: 1,
			InitPropProviders.USE_SPEED: 1,
			InitPropProviders.MOVE_SPEED: 80,
			InitPropProviders.COOLDOWN_REDUCTION: 0
		})
	)


func _ready():
	entity_data.stats.get_property(InitPropProviders.SURVIVOR_LEVEL).connect('level_up', Callable(self, '_on_surv_level_up'))

	var stats_bar = get_ui().get_hud().get_stats_bar()
	var health_prop: HealthProperty = entity_data.stats.get_property(InitPropProviders.HEALTH)
	health_prop.connect('max_health_changed', Callable(stats_bar, '_on_max_health_changed'))
	health_prop.emit_signal('max_health_changed', health_prop.get_max_health())
	health_prop.connect('health_changed', Callable(stats_bar, '_on_health_changed'))
	health_prop.emit_signal('health_changed', health_prop.get_health())
	var mana_prop: ManaProperty = entity_data.stats.get_property(InitPropProviders.MANA)
	mana_prop.connect('max_mana_changed', Callable(stats_bar, '_on_max_mana_changed'))
	mana_prop.emit_signal('max_mana_changed', mana_prop.get_max_mana())
	mana_prop.connect('mana_changed', Callable(stats_bar, '_on_mana_changed'))
	mana_prop.emit_signal('mana_changed', mana_prop.get_mana())


func _physics_process(delta: float) -> void:
	if knockback_vector == Vector2.ZERO:
		# Get the input direction and handle the movement/deceleration.
		direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	super(delta)

# GETTERS AND SETTERS
# Nodes
func get_ui():
	return get_node('WorldUI')

# HANDLERS
func _on_surv_level_up() -> void:
	var health_prov = entity_data.stats.get_property(InitPropProviders.HEALTH)
	health_prov.add_max_health(10)
	health_prov.add_health(10)
	entity_data.stats.get_property(InitPropProviders.FORCE).add_force(2.5)
	entity_data.stats.get_property(InitPropProviders.RESISTANCE).add_resistance(0.5)
	entity_data.stats.get_property(InitPropProviders.PENETRATION).add_penetration(0.2)
