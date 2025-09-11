extends Node

var config = {}


func _ready() -> void:
	var config_file = FileAccess.open(Celestia.GAME_CONFIG_PATH, FileAccess.READ)
	if config_file:
		var content = config_file.get_as_text()
		config = JSON.parse_string(content)
	else:
		push_error('Error loading game settings.')
