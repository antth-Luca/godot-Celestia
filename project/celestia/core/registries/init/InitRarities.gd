extends Object
class_name InitRarities

static var COMMON: BaseRarity
static var UNCOMMON: BaseRarity
static var RARE: BaseRarity
static var EPIC: BaseRarity
static var LEGENDARY: BaseRarity


static func setup() -> void:
	var RARITIES = DeferredRegister.new(
		Celestia.GAME_ID,
		RegistryManager.RARITY_REGISTRY
	)

	COMMON = RARITIES.register(
		'common',
		func():
			var rarity = BaseRarity.new()
			rarity.set_hex_color('#D5D5D5')
			return rarity
	)

	UNCOMMON = RARITIES.register(
		'uncommon',
		func():
			var rarity = BaseRarity.new()
			rarity.set_hex_color('#55A74E')
			return rarity
	)

	RARE = RARITIES.register(
		'rare',
		func():
			var rarity = BaseRarity.new()
			rarity.set_hex_color('#4F7FD9')
			return rarity
	)

	EPIC = RARITIES.register(
		'epic',
		func():
			var rarity = BaseRarity.new()
			rarity.set_hex_color('#A763C2')
			return rarity
	)

	LEGENDARY = RARITIES.register(
		'legendary',
		func():
			var rarity = BaseRarity.new()
			rarity.set_hex_color('#FFC300')
			return rarity
	)
