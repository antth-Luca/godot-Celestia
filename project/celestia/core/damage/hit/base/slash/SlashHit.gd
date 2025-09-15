extends BaseHit
class_name SlashHit

# SUPER
# Godot
func _ready() -> void:
	super()
	ANIMATION.play('slash')

# Getters and setters
func get_hit_data() -> HitData:
	return HitData.new(
		source_entity.entity_data,
		damage_factor,
		HitData.PRIMITIVE_TYPE.PHYSIC,
		HitData.SPECIALIZED_TYPE.NONE
	)

# Handler
func _on_collide(collision: KinematicCollision2D) -> void:
	if collision == null: return
	var body := collision.get_collider()
	if source_entity == body: return
	if body.is_class('TileMapLayer') and body.tile_set.get_physics_layer_collision_layer(1) == 0: despawn_hit()
