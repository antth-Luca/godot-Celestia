extends Node
class_name InitHits

static var HITS: DeferredRegister
# Generic hits
static var ARROW: DeferredHolder
static var SLASH: DeferredHolder


static func setup() -> void:
	HITS = DeferredRegister.create(
		Celestia.GAME_ID,
		HitRegistry.REGISTRY_TYPE
	)

	# Generic hits
	ARROW = HITS.add_entry(
		'arrow',
		func():
			return preload('res://core/damage/hit/custom/arrow/ArrowHit.tscn').instantiate()
	)

	SLASH = HITS.add_entry(
		'slash',
		func():
			return preload('res://core/damage/hit/custom/slash/SlashHit.tscn').instantiate()
	)

	HITS.register()
