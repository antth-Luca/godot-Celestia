extends Node
class_name InitSeeds

static var SEEDS: DeferredRegister
# Seeds
static var ROSE: DeferredHolder


static func setup() -> void:
	SEEDS = DeferredRegister.create(
		Celestia.GAME_ID,
		ItemRegistry.REGISTRY_TYPE
	)

	# Seeds
	ROSE = SEEDS.add_entry(
		'rose',
		func():
			var item = BaseSeed.new()
			item.plant_location = ResourceLocation.new(Celestia.GAME_ID, 'rose_bush')
			item.grow_stages = 4
			item.time_per_stage = 5
			item.set_crop(InitLootBoxes.ROSE_BUSH_DESTROY)
			return item
	)

	SEEDS.register()
