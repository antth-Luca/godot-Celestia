extends Object

var config = {}


func _ready() -> void:
	var config_file = FileAccess.open("res://config/game_config.json", FileAccess.READ)
	if config_file:
		var content = config_file.get_as_text()
		config = JSON.parse_string(content)
	else:
		push_error("Error loading game settings.")
