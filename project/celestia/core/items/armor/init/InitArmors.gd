extends Node
class_name InitArmors

static var ARMORS: DeferredRegister
# Helmets
# Chestplates
static var COPPER_CHESTPLATE: DeferredHolder
static var IRON_CHESTPLATE: DeferredHolder
# Leggings
# Boots


static func setup() -> void:
	ARMORS = DeferredRegister.create(
		Celestia.GAME_ID,
		ItemRegistry.REGISTRY_TYPE
	)

	# Helmets
	# Chestplates
	COPPER_CHESTPLATE = ARMORS.add_entry(
		'copper_chestplate',
		func():
			var armor = BaseArmor.new()
			armor.armor_type = BaseArmor.Type.CHESTPLATE
			armor.material = InitMaterials.COPPER.get_registered()
			armor.set_durability(2)
			armor.protection = 1.5
			return armor
	)

	IRON_CHESTPLATE = ARMORS.add_entry(
		'iron_chestplate',
		func():
			var armor = BaseArmor.new()
			armor.armor_type = BaseArmor.Type.CHESTPLATE
			armor.material = InitMaterials.IRON.get_registered()
			armor.set_durability(2)
			armor.protection = 2
			return armor
	)
	# Leggings
	# Boots

	ARMORS.register()
