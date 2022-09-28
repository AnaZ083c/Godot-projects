extends Control


var settings_path = "res://settings.set"
var settings = File.new()
var settings_save = {"enemy_num": 4, "start_stage": 1}

func _ready():
	if not settings.file_exists(settings_path):
		create_settings()

func create_settings():
	settings.open(settings_path, File.WRITE)
	settings.store_var(settings_save)
	settings.close()
