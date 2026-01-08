# 全局变量脚本
extends Node

@export var is_load:bool = false					# 开场动画是否加载


func _load_settings() -> void:
	var config = ConfigFile.new()
	var err = config.load("user://game_settings.cfg")
	
	if err == OK:
		var music_enabled = config.get_value("audio", "music_enabled", true)
		if music_enabled:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 0.0)
		else:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80.0)


func _ready() -> void:
	_load_settings()
