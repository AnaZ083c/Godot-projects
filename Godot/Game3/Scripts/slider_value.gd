extends Label

onready var parent : HSlider = get_parent()

var settings_path = "res://settings.set"
var settings = File.new()
var settings_save = {"enemy_num": 4, "start_stage": 1}
var enemy_num
var starting_stage
var saved_settings


############## MAIN ################
func _ready():
	# text = str(parent.value)
	if not settings.file_exists(settings_path):
		create_settings()
	
	saved_settings = read_settings()
	enemy_num = saved_settings[0]
	starting_stage = saved_settings[1]
	
	print("enemy_num = ", enemy_num)
	print("starting_stage = ", starting_stage)
	
	match(parent.name):
		"enemy_num": 
			parent.value = enemy_num
			text = str(parent.value)
		"starting_stage": 
			parent.value = starting_stage
			text = str(parent.value)

func _on_starting_stage_value_changed(value):
	text = str(parent.value)
	starting_stage = int(text)

func _on_enemy_num_value_changed(value):
	text = str(parent.value)
	enemy_num = int(text)
	print("changed enemy num: ", enemy_num)


############## FILE READ WRITE #################
func read_settings():
	settings.open(settings_path, File.READ)
	settings_save = settings.get_var()
	settings.close()
	return [settings_save["enemy_num"], settings_save["start_stage"]]
	
func save_settings(enemy_num, start_stage):
	settings_save["enemy_num"] = enemy_num
	settings_save["start_stage"] = start_stage
	settings.open(settings_path, File.WRITE)
	settings.store_var(settings_save)
	settings.close()
	
func create_settings():
	settings.open(settings_path, File.WRITE)
	settings.store_var(settings_save)
	settings.close()


func _on_save_pressed():
	print("------\nSAVING:")
	print("enemy_num = ", enemy_num)
	print("starting_stage = ", starting_stage)
	save_settings(enemy_num, starting_stage)
