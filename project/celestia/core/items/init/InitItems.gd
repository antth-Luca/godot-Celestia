extends Node
class_name InitItems

static var ITEMS: DeferredRegister
# Items
static var ASTRONITE_INGOT: DeferredHolder
static var CARNIGO_INGOT: DeferredHolder
static var CERAMIC_BOWL: DeferredHolder
static var CLAY_BOWL: DeferredHolder
static var COBBLESTONE: DeferredHolder
static var COMPASS: DeferredHolder
static var ERUPTITE_INGOT: DeferredHolder
static var FABRIC: DeferredHolder
static var FEATHER: DeferredHolder
static var FULGURITE: DeferredHolder
static var GOLD_INGOT: DeferredHolder
static var HANDFUL_OF_CLAY: DeferredHolder
static var HANDFUL_OF_DIRT: DeferredHolder
static var IRON_INGOT: DeferredHolder
static var LEATHER: DeferredHolder
static var MAGMA_STONE: DeferredHolder
static var OBSIDIAN: DeferredHolder
static var PAPYRUS: DeferredHolder
static var PLANT_FIBER: DeferredHolder
static var RUBY: DeferredHolder
static var STARDUST: DeferredHolder
static var STONE: DeferredHolder
static var WATER_BOWL: DeferredHolder
# Constellation scrolls
static var SCROLL_ALTRUISM: DeferredHolder
static var SCROLL_AMBITION: DeferredHolder
static var SCROLL_ASCENDANCE: DeferredHolder
static var SCROLL_CALM: DeferredHolder
static var SCROLL_CHAOS: DeferredHolder
static var SCROLL_CREATION: DeferredHolder
static var SCROLL_DESTRUCTION: DeferredHolder
static var SCROLL_EFEMERALITY: DeferredHolder
static var SCROLL_ILLUSION: DeferredHolder
static var SCROLL_PERMANENCE: DeferredHolder
static var SCROLL_PROTECTION: DeferredHolder
static var SCROLL_SUBMISSION: DeferredHolder
static var SCROLL_TRUTH: DeferredHolder
static var SCROLL_WAR: DeferredHolder


static func setup() -> void:
	ITEMS = DeferredRegister.create(
		Celestia.GAME_ID,
		ItemRegistry.REGISTRY_TYPE
	)

	# Items
	ASTRONITE_INGOT = ITEMS.add_entry(
		'astronite_ingot',
		func():
			var item = BaseItem.new()
			item.rarity = InitRarities.UNCOMMON.get_registered()
			return item
	)

	CARNIGO_INGOT = ITEMS.add_entry(
		'carnigo_ingot',
		func(): return BaseItem.new()
	)

	CERAMIC_BOWL = ITEMS.add_entry(
		'ceramic_bowl',
		func(): return CeramicBowlItem.new()
	)

	CLAY_BOWL = ITEMS.add_entry(
		'clay_bowl',
		func(): return BaseItem.new()
	)

	COBBLESTONE = ITEMS.add_entry(
		'cobblestone',
		func(): return BaseItem.new()
	)

	COMPASS = ITEMS.add_entry(
		'compass',
		func(): return BaseItem.new()
	)

	ERUPTITE_INGOT = ITEMS.add_entry(
		'eruptite_ingot',
		func(): return BaseItem.new()
	)

	FABRIC = ITEMS.add_entry(
		'fabric',
		func(): return BaseItem.new()
	)

	FEATHER = ITEMS.add_entry(
		'feather',
		func(): return BaseItem.new()
	)

	FULGURITE = ITEMS.add_entry(
		'fulgurite',
		func(): return BaseItem.new()
	)

	GOLD_INGOT = ITEMS.add_entry(
		'gold_ingot',
		func(): return BaseItem.new()
	)

	HANDFUL_OF_CLAY = ITEMS.add_entry(
		'handful_of_clay',
		func(): return BaseItem.new()
	)

	HANDFUL_OF_DIRT = ITEMS.add_entry(
		'handful_of_dirt',
		func(): return HandfulOfDirtItem.new()
	)

	IRON_INGOT = ITEMS.add_entry(
		'iron_ingot',
		func(): return BaseItem.new()
	)

	LEATHER = ITEMS.add_entry(
		'leather',
		func(): return BaseItem.new()
	)

	MAGMA_STONE = ITEMS.add_entry(
		'magma_stone',
		func(): return BaseItem.new()
	)

	OBSIDIAN = ITEMS.add_entry(
		'obsidian',
		func(): return BaseItem.new()
	)

	PAPYRUS = ITEMS.add_entry(
		'papyrus',
		func(): return BaseItem.new()
	)

	PLANT_FIBER = ITEMS.add_entry(
		'plant_fiber',
		func(): return BaseItem.new()
	)

	RUBY = ITEMS.add_entry(
		'ruby',
		func(): return BaseItem.new()
	)

	STARDUST = ITEMS.add_entry(
		'stardust',
		func():
			var item = BaseItem.new()
			item.rarity = InitRarities.UNCOMMON.get_registered()
			return item
	)

	STONE = ITEMS.add_entry(
		'stone',
		func(): return BaseItem.new()
	)

	WATER_BOWL = ITEMS.add_entry(
		'water_bowl',
		func(): return BaseItem.new()
	)
	# Constellation scrolls
	SCROLL_ALTRUISM = ITEMS.add_entry(
		'scroll_altruism',
		func():
			var item = BaseItem.new()
			item.rarity = InitRarities.UNCOMMON.get_registered()
			return item
	)

	SCROLL_AMBITION = ITEMS.add_entry(
		'scroll_ambition',
		func():
			var item = BaseItem.new()
			item.rarity = InitRarities.UNCOMMON.get_registered()
			return item
	)

	SCROLL_ASCENDANCE = ITEMS.add_entry(
		'scroll_ascendance',
		func():
			var item = BaseItem.new()
			item.rarity = InitRarities.UNCOMMON.get_registered()
			return item
	)

	SCROLL_CALM = ITEMS.add_entry(
		'scroll_calm',
		func():
			var item = BaseItem.new()
			item.rarity = InitRarities.UNCOMMON.get_registered()
			return item
	)

	SCROLL_CHAOS = ITEMS.add_entry(
		'scroll_chaos',
		func():
			var item = BaseItem.new()
			item.rarity = InitRarities.UNCOMMON.get_registered()
			return item
	)

	SCROLL_CREATION = ITEMS.add_entry(
		'scroll_creation',
		func():
			var item = BaseItem.new()
			item.rarity = InitRarities.UNCOMMON.get_registered()
			return item
	)

	SCROLL_DESTRUCTION = ITEMS.add_entry(
		'scroll_destruction',
		func():
			var item = BaseItem.new()
			item.rarity = InitRarities.UNCOMMON.get_registered()
			return item
	)

	SCROLL_EFEMERALITY = ITEMS.add_entry(
		'scroll_efemerality',
		func():
			var item = BaseItem.new()
			item.rarity = InitRarities.UNCOMMON.get_registered()
			return item
	)

	SCROLL_ILLUSION = ITEMS.add_entry(
		'scroll_illusion',
		func():
			var item = BaseItem.new()
			item.rarity = InitRarities.UNCOMMON.get_registered()
			return item
	)

	SCROLL_PERMANENCE = ITEMS.add_entry(
		'scroll_permanence',
		func():
			var item = BaseItem.new()
			item.rarity = InitRarities.UNCOMMON.get_registered()
			return item
	)

	SCROLL_PROTECTION = ITEMS.add_entry(
		'scroll_protection',
		func():
			var item = BaseItem.new()
			item.rarity = InitRarities.UNCOMMON.get_registered()
			return item
	)

	SCROLL_SUBMISSION = ITEMS.add_entry(
		'scroll_submission',
		func():
			var item = BaseItem.new()
			item.rarity = InitRarities.UNCOMMON.get_registered()
			return item
	)

	SCROLL_TRUTH = ITEMS.add_entry(
		'scroll_truth',
		func():
			var item = BaseItem.new()
			item.rarity = InitRarities.UNCOMMON.get_registered()
			return item
	)

	SCROLL_WAR = ITEMS.add_entry(
		'scroll_war',
		func():
			var item = BaseItem.new()
			item.rarity = InitRarities.UNCOMMON.get_registered()
			return item
	)

	ITEMS.register()
