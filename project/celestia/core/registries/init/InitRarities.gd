extends Object
class_name InitRarities


static var RARITIES = DeferredRegister.create(
	Celestia.GAME_ID,
	RarityRegistry.REGISTRY_TYPE
)

# Rarities
static var COMMON: DeferredHolder = RARITIES.add_entry(
	'common',
	func():
		var rarity = BaseRarity.new()
		rarity.set_hex_color('#D5D5D5')
		return rarity
)

static var UNCOMMON: DeferredHolder = RARITIES.add_entry(
	'uncommon',
	func():
		var rarity = BaseRarity.new()
		rarity.set_hex_color('#55A74E')
		return rarity
)

static var RARE: DeferredHolder = RARITIES.add_entry(
	'rare',
	func():
		var rarity = BaseRarity.new()
		rarity.set_hex_color('#4F7FD9')
		return rarity
)

static var EPIC: DeferredHolder = RARITIES.add_entry(
	'epic',
	func():
		var rarity = BaseRarity.new()
		rarity.set_hex_color('#A763C2')
		return rarity
)

static var LEGENDARY: DeferredHolder = RARITIES.add_entry(
	'legendary',
	func():
		var rarity = BaseRarity.new()
		rarity.set_hex_color('#FFC300')
		return rarity
)
