extends Object
class_name InitMaterials

static var GENERIC: BaseMaterial
static var WOOD: BaseMaterial
static var STONE: BaseMaterial
static var FULGURITE: BaseMaterial
static var COPPER: BaseMaterial
static var ERUPTITE: BaseMaterial
static var CARNIGO: BaseMaterial
static var IRON: BaseMaterial
static var DARK_IRON: BaseMaterial
static var ASTRONITE: BaseMaterial
static var LUNATITE: BaseMaterial
static var CELESTITE: BaseMaterial


static func setup() -> void:
	var MATERIALS = DeferredRegister.new(
		Celestia.GAME_ID,
		RegistryManager.MATERIAL_REGISTRY
	)

	GENERIC = MATERIALS.register(
		'generic',
		func():
			return BaseMaterial.new()
	)

	WOOD = MATERIALS.register(
		'wood',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(32)
			material.set_efficiency(0)
			return material
	)

	STONE = MATERIALS.register(
		'stone',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(48)
			material.set_efficiency(1)
			return material
	)

	FULGURITE = MATERIALS.register(
		'fulgurite',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(58)
			return material
	)

	COPPER = MATERIALS.register(
		'copper',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(65)
			material.set_efficiency(2)
			return material
	)

	ERUPTITE = MATERIALS.register(
		'eruptite',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(74)
			material.set_efficiency(2)
			return material
	)

	CARNIGO = MATERIALS.register(
		'carnigo',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(90)
			material.set_efficiency(2)
			return material
	)

	IRON = MATERIALS.register(
		'iron',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(112)
			material.set_efficiency(3)
			return material
	)

	DARK_IRON = MATERIALS.register(
		'dark_iron',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(122)
			material.set_efficiency(3)
			return material
	)

	ASTRONITE = MATERIALS.register(
		'astronite',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(160)
			material.set_efficiency(4)
			return material
	)

	LUNATITE = MATERIALS.register(
		'lunatite',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(208)
			material.set_efficiency(5)
			return material
	)

	CELESTITE = MATERIALS.register(
		'celestite',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(272)
			material.set_efficiency(6)
			return material
	)
