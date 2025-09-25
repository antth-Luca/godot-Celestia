extends Node

static var registries: Dictionary = {
	RarityRegistry.REGISTRY_TYPE: RarityRegistry.new(),
	MaterialRegistry.REGISTRY_TYPE: MaterialRegistry.new(),
	ItemRegistry.REGISTRY_TYPE: ItemRegistry.new(),
	RecipeRegistry.REGISTRY_TYPE: RecipeRegistry.new(),
	LootBoxRegistry.REGISTRY_TYPE: LootBoxRegistry.new(),
	StructureRegistry.REGISTRY_TYPE: StructureRegistry.new(),
	PropProviderRegistry.REGISTRY_TYPE: PropProviderRegistry.new(),
	HitRegistry.REGISTRY_TYPE: HitRegistry.new(),
	EntityRegistry.REGISTRY_TYPE: EntityRegistry.new()
}
