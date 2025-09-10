extends LivingEntity
class_name Player

var inventory: InventoryManager
var hand: PlayerHand

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
	# Survivor level signal
	entity_data.stats.get_property(InitPropProviders.SURVIVOR_LEVEL).connect('level_up', Callable(self, '_on_surv_level_up'))
	# Stats bar signals
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
	# Inventory
	inventory = get_ui().get_invent_panel().get_inventory_tab()
	inventory.player = self
	# World UI
	get_ui().player = self
	# Player Hand
	hand = get_hand()
	hand.player = self
	# Item Hand Animation
	hand.set_item_hand_texture(inventory.get_hand().item)


func _physics_process(delta: float) -> void:
	if knockback_vector == Vector2.ZERO:
		# Get the input direction and handle the movement/deceleration.
		direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	super(delta)

# SUPER
# Animation
func set_animation() -> void:
	var anim = 'idle'
	if direction != Vector2.ZERO: anim = 'walk'
	if ANIMATION.current_animation != anim: ANIMATION.play(anim)
	if not hand.is_using and hand.ITEM_HAND_ANIMATION.current_animation != anim: hand.ITEM_HAND_ANIMATION.play(anim)

# Handlers
func flip_texture() -> void:
	var mouse_direction: Vector2 = global_position.direction_to(get_global_mouse_position())
	TEXTURE.flip_h = mouse_direction.x < 0
	hand.ITEM_HAND_TEXTURE.flip_h = mouse_direction.x < 0

# GETTERS AND SETTERS
# Nodes
func get_ui() -> WorldUI:
	return get_node('WorldUI')


func get_hand() -> PlayerHand:
	return get_node('Hand')

# HANDLERS
# Survivor level
func _on_surv_level_up() -> void:
	var health_prov = entity_data.stats.get_property(InitPropProviders.HEALTH)
	health_prov.add_max_health(10)
	health_prov.add_health(10)
	entity_data.stats.get_property(InitPropProviders.FORCE).add_force(2.5)
	entity_data.stats.get_property(InitPropProviders.RESISTANCE).add_resistance(0.5)
	entity_data.stats.get_property(InitPropProviders.PENETRATION).add_penetration(0.2)

# Use
func perform_use_item_hand() -> void:
	var stack_hand: ItemStack = inventory.get_hand()
	if stack_hand.is_empty(): return
	hand.is_using = true
	stack_hand.item.use(self)
	hand.ITEM_HAND_ANIMATION.play(stack_hand.item.anim_type)
