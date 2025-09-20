extends Node
class_name InitFoods

static var FOODS: DeferredRegister
# Foods
static var EGG: DeferredHolder


static func setup() -> void:
	FOODS = DeferredRegister.create(
		Celestia.GAME_ID,
		FoodRegistry.REGISTRY_TYPE
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

	FOODS.register()
