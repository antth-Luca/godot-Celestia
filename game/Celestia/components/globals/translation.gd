extends Node

var translation = {}

func _ready() -> void:
	load_translations()


func load_translations() -> void:
	var tr_file = FileAccess.open("res://assets/lang/%s.json" % GameConfig.config.get('language'), FileAccess.READ)
	if tr_file:
		var content = tr_file.get_as_text()
		translation = JSON.parse_string(content)
	else:
		push_error("Error loading translation.")


func t(key: String) -> String:
	return translation.get(key)
