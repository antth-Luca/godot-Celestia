extends BaseItem
class_name BaseTool

var damage_factor: float = 1
var base_lifespan: float = 1:
	set(new_base):
		base_lifespan = max(new_base, 0)
var hit_type: DeferredHolder = InitHits.SLASH

# SUPER
# Godot
func _init():
	max_stack = 1

# Getters and Setters
static func get_static_comparable_name() -> String:
	return 'BaseTool'


func get_comparable_name() -> String:
	return BaseTool.get_static_comparable_name()


func get_tooltip() -> Array[String]:
	var lines = super.get_tooltip()
	lines.insert(2, '[color=%s]%s:\n  %sx %s\n  %sx %s[/color]\n' % [
		COMMON_TEXT_COLOR,
		tr(Celestia.TRANSLATION_KEY_BASES.SECTION_TITLE % 'when_use'),
		use_speed_factor, tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'US'),
		damage_factor, tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'FR')
	])
	return lines

# Main
func copy(copy_obj: Variant = BaseTool.new()) -> Variant:
	copy_obj = super.copy(copy_obj)
	copy_obj.damage_factor = damage_factor
	copy_obj.base_lifespan = base_lifespan
	copy_obj.hit_type = hit_type
	return copy_obj


func use(player: Player) -> void:
	HitUtils.spawn_hit(player, hit_type, self)
	consume_durability(1, player.inventory.get_hand())
	set_cooldown(player)
