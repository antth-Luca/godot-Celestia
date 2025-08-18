extends Object
class_name InitMaterials


static var MATERIALS = DeferredRegister.create(
	Celestia.GAME_ID,
	MaterialRegistry.REGISTRY_TYPE
)

# Materials
static var GENERIC: DeferredHolder = MATERIALS.add_entry(
	'generic',
	func():
		return BaseMaterial.new()
)

static var WOOD: DeferredHolder = MATERIALS.add_entry(
	'wood',
	func():
		var material = BaseMaterial.new()
		material.set_base_max_damage(32)
		material.set_efficiency(0)
		return material
)

static var STONE: DeferredHolder = MATERIALS.add_entry(
	'stone',
	func():
		var material = BaseMaterial.new()
		material.set_base_max_damage(48)
		material.set_efficiency(1)
		return material
)

static var FULGURITE: DeferredHolder = MATERIALS.add_entry(
	'fulgurite',
	func():
		var material = BaseMaterial.new()
		material.set_base_max_damage(58)
		return material
)

static var COPPER: DeferredHolder = MATERIALS.add_entry(
	'copper',
	func():
		var material = BaseMaterial.new()
		material.set_base_max_damage(65)
		material.set_efficiency(2)
		return material
)

static var ERUPTITE: DeferredHolder = MATERIALS.add_entry(
	'eruptite',
	func():
		var material = BaseMaterial.new()
		material.set_base_max_damage(74)
		material.set_efficiency(2)
		return material
)

static var CARNIGO: DeferredHolder = MATERIALS.add_entry(
	'carnigo',
	func():
		var material = BaseMaterial.new()
		material.set_base_max_damage(90)
		material.set_efficiency(2)
		return material
)

static var IRON: DeferredHolder = MATERIALS.add_entry(
	'iron',
	func():
		var material = BaseMaterial.new()
		material.set_base_max_damage(112)
		material.set_efficiency(3)
		return material
)

static var DARK_IRON: DeferredHolder = MATERIALS.add_entry(
	'dark_iron',
	func():
		var material = BaseMaterial.new()
		material.set_base_max_damage(122)
		material.set_efficiency(3)
		return material
)

static var ASTRONITE: DeferredHolder = MATERIALS.add_entry(
	'astronite',
	func():
		var material = BaseMaterial.new()
		material.set_base_max_damage(160)
		material.set_efficiency(4)
		return material
)

static var LUNATITE: DeferredHolder = MATERIALS.add_entry(
	'lunatite',
	func():
		var material = BaseMaterial.new()
		material.set_base_max_damage(208)
		material.set_efficiency(5)
		return material
)

static var CELESTITE: DeferredHolder = MATERIALS.add_entry(
	'celestite',
	func():
		var material = BaseMaterial.new()
		material.set_base_max_damage(272)
		material.set_efficiency(6)
		return material
)
