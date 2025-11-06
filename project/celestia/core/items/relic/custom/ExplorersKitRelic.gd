extends BaseRelic
class_name ExplorersKitRelic

# SUPER
# Godot
func _init() -> void:
	super._init()
	rarity = InitRarities.UNCOMMON.get_registered()

# Getters and setters
func get_tooltip() -> Array[String]:
	var lines: Array[String] = super.get_tooltip()
	lines.insert(3, '[color=%s] -> %s[/color]\n' % [
		COMMON_TEXT_COLOR,
		tr(Celestia.TRANSLATION_KEY_BASES.ITEM_DESC % id.path)
	])
	return lines

# Handlers
func on_equip(slot: BaseSlot, _player: Player) -> void:
	if slot.slot_type == BaseSlot.Type.RELIC:
		print('Mini-mapa ativado!')  # TODO: Implementar mini-mapa.


func on_unequip(slot: BaseSlot, _player: Player):
	if slot.slot_type == BaseSlot.Type.RELIC:
		print('Mini-mapa desativado!')  # TODO: Implementar mini-mapa.
