extends Object

# IMPORTS
# Client
const PlayerEvents = preload("res://core/events/client/PlayerEvents.gd")
const InventoryEvents = preload("res://core/events/client/InventoryEvents.gd")
# Common
# Server

# COUPLING
# Client
var client_player = PlayerEvents.new()
var client_inventory = InventoryEvents.new()
# Common
# Server
