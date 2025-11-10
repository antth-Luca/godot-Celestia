extends BaseItem
class_name BaseSeed

var plant_location: ResourceLocation
var grow_stages: int
var time_per_stage: float
var _crop: Variant  # as Ingredient or LootBox

# SUPER
# Getters and setters
static func get_static_comparable_name() -> String:
	return 'BaseSeed'


func get_comparable_name() -> String:
	return BaseSeed.get_static_comparable_name()

# Main
func copy(copy_obj: Variant = BaseSeed.new) -> Variant:
	copy_obj = super.copy(copy_obj)
	copy_obj.plant_location = plant_location
	copy_obj.grow_stages = grow_stages
	copy_obj.time_per_stage = time_per_stage
	return copy_obj

# GETTERS AND SETTERS
func get_crop(player: Player = null) -> Array[ItemStack]:
	if _crop is Ingredient:
		return [ItemStack.new(_crop.item_holder.get_registered(), _crop.amount)]
	else:
		var crop_obj = _crop.get_registered()
		if crop_obj is LootBox:
			return crop_obj.get_sorted_output(player)
		push_error('BaseSeed: The crop defined as DeferredHolder must be a holder for LootBox.')
		return []


func set_crop(new_crop: Variant) -> void:
	if new_crop is Ingredient or new_crop is DeferredHolder:
		_crop = new_crop
		return
	push_error('BaseSeed: The crop to be defined must be of the Ingredient or DeferredHolder class (in the case of the holder, use LootBox).')
