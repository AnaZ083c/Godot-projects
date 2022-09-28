extends Node2D

var settings_path = "res://settings.set"
var settings = File.new()
var settings_save = {"enemy_num": 4, "start_stage": 1, "fullscreen": false, "vhs_crt": true}

var fullscreen : bool = false

func _ready():
	if not settings.file_exists(settings_path):
		create_settings()
	
	fullscreen = get_fullscreen()
	set_fullscreen()
		
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	
func create_settings():
	settings.open(settings_path, File.WRITE)
	settings.store_var(settings_save)
	settings.close()

func get_fullscreen():
	settings.open(settings_path, File.READ)
	settings_save = settings.get_var()
	settings.close()
	return settings_save["fullscreen"]
	
func set_fullscreen():
	OS.window_maximized = fullscreen
	OS.window_borderless = fullscreen
	
	if fullscreen:
		OS.window_size = OS.get_screen_size()
		OS.window_position = Vector2(0, 0)
	else:
		OS.window_size = Vector2(1024, 600)
		OS.center_window()
