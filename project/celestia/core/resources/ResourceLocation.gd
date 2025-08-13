extends RefCounted
class_name ResourceLocation

var space: String
var path: String

func _init(sp: String, pa: String):
	if ':' in sp or ':' in pa:
		push_error('ResourceLocation: space and path cannot contain ":".')
	space = sp
	path = pa


func get_string() -> String:
	return "%s:%s" % [space, path]


func get_splited() -> Array[String]:
	return [space, path]


static func from_string(full_id: String) -> ResourceLocation:
	var parts = full_id.split(':')
	if parts.size() != 2:
		push_error('ResourceLocation: invalid complete ID "%s" received.' % full_id)
		return null
	return ResourceLocation.new(parts[0], parts[1])
