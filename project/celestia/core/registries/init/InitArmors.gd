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
			armor.set_armor_type(ArmorTypes.CHESTPLATE)
			armor.set_durability_factor(2)
			armor.set_material(InitMaterials.IRON.get_registered())
			armor.add_attribute_modifier(AttributeModifier.new(
				InitPropProviders.ARMOR,
				'+1.5'
			))
			return armor
	)
	# Leggings
	# Boots

	ARMORS.register()
