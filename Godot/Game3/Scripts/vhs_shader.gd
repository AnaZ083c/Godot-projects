extends CanvasLayer

var settings_path = "res://settings.set"
var settings = File.new()
var settings_save = {"enemy_num": 4, "start_stage": 1, "fullscreen": false, "vhs_crt": true}

var vhs_on : bool = true

func _ready():
	if settings.file_exists(settings_path):
		vhs_on = get_vhs_on()
	$crt_shader.visible = vhs_on


### READ FROM FILE ###
func get_vhs_on():
	settings.open(settings_path, File.READ)
	settings_save = settings.get_var()
	settings.close()
	return settings_save["vhs_crt"]


func _on_vhs_toggled(button_pressed):
	$crt_shader.visible = button_pressed
