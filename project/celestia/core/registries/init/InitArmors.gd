extends RefCounted
class_name InitArmors


static var ARMORS = DeferredRegister.create(
	Celestia.GAME_ID,
	ArmorRegistry.REGISTRY_TYPE
)

# Helmets
# Chestplates
static var IRON_CHESTPLATE: DeferredHolder = ARMORS.add_entry(
	'iron_chestplate',
	func():
		var armor = BaseArmor.new()
		armor.set_armor_type(ArmorTypes.CHESTPLATE)
		armor.set_protection(1.5)
		armor.set_durability_factor(2)
		armor.set_material(InitMaterials.IRON.get_registered())
		return armor
)
# Leggings
# Boots
