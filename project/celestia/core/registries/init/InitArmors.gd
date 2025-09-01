extends Node
class_name InitArmors

static var ARMORS: DeferredRegister
# Helmets
# Chestplates
static var IRON_CHESTPLATE: DeferredHolder
# Leggings
# Boots


static func setup() -> void:
	ARMORS = DeferredRegister.create(
		Celestia.GAME_ID,
		ArmorRegistry.REGISTRY_TYPE
	)

	# Helmets
	# Chestplates
	IRON_CHESTPLATE = ARMORS.add_entry(
		'iron_chestplate',
		func():
			var armor = BaseArmor.new()
			armor.armor_type = BaseArmor.Type.CHESTPLATE
			armor.durability_factor = 2
			armor.material = InitMaterials.IRON.get_registered()
			armor.protection = 1.5
			return armor
	)
	# Leggings
	# Boots

	ARMORS.register()
