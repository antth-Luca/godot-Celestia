extends Node
class_name InitFoods

static var FOODS: DeferredRegister
# Foods
static var EGG: DeferredHolder
static var MEAT: DeferredHolder
static var UNCLEAN_MEAT: DeferredHolder
static var BEEF: DeferredHolder


static func setup() -> void:
	FOODS = DeferredRegister.create(
		Celestia.GAME_ID,
		ItemRegistry.REGISTRY_TYPE
	)

	# Foods
	EGG = FOODS.add_entry(
		'egg',
		func():
			var food = BaseFood.new()
			food.max_stack = 12
			food.satiation = 3
			return food
	)

	MEAT = FOODS.add_entry(
		'meat',
		func():
			var food = BaseFood.new()
			food.satiation = 5
			food.regen_hp = .5
			return food
	)

	UNCLEAN_MEAT = FOODS.add_entry(
		'unclean_meat',
		func():
			var food = BaseFood.new()
			food.satiation = 1.5
			return food
	)

	BEEF = FOODS.add_entry(
		'beef',
		func():
			var food = BaseFood.new()
			food.satiation = 5.5
			food.regen_hp = 1.5
			return food
	)

	FOODS.register()
