extends Object
class_name InitArmors

static var IRON_CHESTPLATE: BaseArmor

static func setup() -> void:
	var ARMORS = DeferredRegister.new(
		Celestia.GAME_ID,
		RegistryManager.ARMOR_REGISTRY
	)

	IRON_CHESTPLATE = ARMORS.register(
		'iron_chestplate',
		func():
			var armor = BaseArmor.new()
			armor.set_armor_attribute(1.5)
			armor.set_armor_type(ArmorTypes.CHESTPLATE)
			armor.set_material(InitMaterials.IRON)
			armor.set_durability_factor(2)
			return armor
	)
