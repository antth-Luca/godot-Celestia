extends Node
class_name InitItems

static var ITEMS: DeferredRegister
# Items
static var BONE: DeferredHolder
static var COBBLESTONE: DeferredHolder
static var GOLD_INGOT: DeferredHolder
static var IRON_INGOT: DeferredHolder
static var PAPYRUS: DeferredHolder
static var PLANT_FIBER: DeferredHolder
static var STARDUST: DeferredHolder
static var STONE: DeferredHolder
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
	BONE = ITEMS.add_entry(
		'bone',
		func(): return BaseItem.new()
	)

	COBBLESTONE = ITEMS.add_entry(
		'cobblestone',
		func(): return BaseItem.new()
	)

	GOLD_INGOT = ITEMS.add_entry(
		'gold_ingot',
		func(): return BaseItem.new()
	)

	IRON_INGOT = ITEMS.add_entry(
		'iron_ingot',
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
