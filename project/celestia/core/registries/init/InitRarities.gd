extends Node
class_name InitRarities

static var RARITIES: DeferredRegister
# Rarities
static var COMMON: DeferredHolder
static var UNCOMMON: DeferredHolder
static var RARE: DeferredHolder
static var EPIC: DeferredHolder
static var LEGENDARY: DeferredHolder


func _ready() -> void:
	RARITIES = DeferredRegister.create(
		Celestia.GAME_ID,
		RarityRegistry.REGISTRY_TYPE
	)

# Rarities
	COMMON = RARITIES.add_entry(
		'common',
		func():
			var rarity = BaseRarity.new()
			rarity.set_hex_color('#D5D5D5')
			return rarity
	)

	UNCOMMON = RARITIES.add_entry(
		'uncommon',
		func():
			var rarity = BaseRarity.new()
			rarity.set_hex_color('#55A74E')
			return rarity
	)

	RARE = RARITIES.add_entry(
		'rare',
		func():
			var rarity = BaseRarity.new()
			rarity.set_hex_color('#4F7FD9')
			return rarity
	)

	EPIC = RARITIES.add_entry(
		'epic',
		func():
			var rarity = BaseRarity.new()
			rarity.set_hex_color('#A763C2')
			return rarity
	)

	LEGENDARY = RARITIES.add_entry(
		'legendary',
		func():
			var rarity = BaseRarity.new()
			rarity.set_hex_color('#FFC300')
			return rarity
	)
