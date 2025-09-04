extends Node

static var registries: Dictionary = {
	RarityRegistry.REGISTRY_TYPE: RarityRegistry.new(),
	MaterialRegistry.REGISTRY_TYPE: MaterialRegistry.new(),
	ItemRegistry.REGISTRY_TYPE: ItemRegistry.new(),
	ToolRegistry.REGISTRY_TYPE: ToolRegistry.new(),
	ArmorRegistry.REGISTRY_TYPE: ArmorRegistry.new(),
	PropProviderRegistry.REGISTRY_TYPE: PropProviderRegistry.new()
}
