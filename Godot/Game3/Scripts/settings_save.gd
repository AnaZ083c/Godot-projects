extends Control

onready var enemy_num_slider : HSlider = $num_of_enemies/enemy_num
onready var enemy_num_label : Label = $num_of_enemies/enemy_num/value
onready var fullscreen : CheckBox = get_parent().get_node("fullscreen/fullscreen")
onready var vhs_crt : CheckBox = get_parent().get_node("vhs_on_off/vhs")

onready var starting_stage_slider : HSlider = $starting_speed/starting_stage
onready var starting_stage_label : Label = $starting_speed/starting_stage/value

var settings_path = "res://settings.set"
var settings = File.new()
var settings_save = {"enemy_num": 4, "start_stage": 1, "fullscreen": false, "vhs_crt": true}
var enemy_num
var starting_stage
var fullscreen_settings
var vhs_crt_settings
var saved_settings



############## MAIN ################

func _ready():	
	saved_settings = read_settings()
	enemy_num = saved_settings[0]
	starting_stage = saved_settings[1]
	fullscreen_settings = saved_settings[2]
	vhs_crt_settings = saved_settings[3]
	
	enemy_num_slider.value = enemy_num
	enemy_num_label.text = str(enemy_num)
	
	starting_stage_slider.value = starting_stage
	starting_stage_label.text = str(starting_stage)
	
	fullscreen.pressed = fullscreen_settings
	vhs_crt.pressed = vhs_crt_settings


############## FILE READ WRITE #################

func read_settings():
	settings.open(settings_path, File.READ)
	settings_save = settings.get_var()
	settings.close()
	return [settings_save["enemy_num"], settings_save["start_stage"], settings_save["fullscreen"], settings_save["vhs_crt"]]
	
func save_settings(_enemy_num, _start_stage, _fullscreen, _vhs_crt):
	settings_save["enemy_num"] = _enemy_num
	settings_save["start_stage"] = _start_stage
	settings_save["fullscreen"] = _fullscreen
	settings_save["vhs_crt"] = _vhs_crt
	
	settings.open(settings_path, File.WRITE)
	settings.store_var(settings_save)
	settings.close()


################# CONNECTIONS ####################

func _on_save_pressed():
	enemy_num = enemy_num_slider.value
	starting_stage = starting_stage_slider.value
	fullscreen_settings = fullscreen.pressed
	vhs_crt_settings = vhs_crt.pressed

	save_settings(enemy_num, starting_stage, fullscreen_settings, vhs_crt_settings)
