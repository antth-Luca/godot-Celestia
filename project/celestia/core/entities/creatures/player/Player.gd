extends LivingEntity
class_name Player

@onready var ITEM_HAND_TEXTURE: Sprite2D = $ItemHandTexture
@onready var ITEM_HAND_ANIMATION: AnimationPlayer = $ItemHandAnimation

var inventory: InventoryManager

var is_attacking: bool = false

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
	# Item Hand Animation
	set_item_hand_texture(get_item_in_hand().item)


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
	if not is_attacking and ITEM_HAND_ANIMATION.current_animation != anim: ITEM_HAND_ANIMATION.play(anim)

# Handlers
func flip_texture(x_dir) -> void:
	super(x_dir)
	ITEM_HAND_TEXTURE.flip_h = x_dir < 0

# GETTERS AND SETTERS
# Nodes
func get_ui() -> WorldUI:
	return get_node('WorldUI')

# Item Hand
func set_item_hand_texture(item_hand: BaseItem) -> void:
	if item_hand: ITEM_HAND_TEXTURE.texture = load('res://assets/%s/textures/items/%s.png' % item_hand.id.get_splited())

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
	var stack_hand: ItemStack = get_item_in_hand()
	is_attacking = true
	stack_hand.item.use(self)
	await ITEM_HAND_ANIMATION.play(stack_hand.item.anim_type)
	is_attacking = false

# Inventory
func get_item_in_hand() -> ItemStack:
	return inventory.inventory[InventoryManager.MIN_SLOTS]


func get_items_in_pocket() -> Array[ItemStack]:
	return inventory.inventory.slice(InventoryManager.MIN_SLOTS, InventoryManager.POCKET_LAST_POSITION + 1)


func get_items_in_backpack() -> Array[ItemStack]:
	return inventory.inventory.slice(InventoryManager.POCKET_LAST_POSITION + 1, InventoryManager.BACKPACK_LAST_POSITION + 1)


func get_armor_equiped() -> Array[ItemStack]:
	return inventory.inventory.slice(InventoryManager.BACKPACK_LAST_POSITION + 1, InventoryManager.ARMOR_LAST_POSITION + 1)


func get_relic_equipped() -> Array[ItemStack]:
	return inventory.inventory.slice(InventoryManager.ARMOR_LAST_POSITION + 1, InventoryManager.RELIC_LAST_POSITION + 1)


func get_ammo_available() -> Array[ItemStack]:
	return inventory.inventory.slice(InventoryManager.RELIC_LAST_POSITION + 1, InventoryManager.AMMO_LAST_POSITION + 1)
