extends GridContainer


var main_scene_res = load("res://main.tscn")
var main_scene = main_scene_res.instance()


onready var ui_hover : AudioStreamPlayer = get_parent().get_parent().get_parent().get_node("ui_hover")
onready var ui_select : AudioStreamPlayer = get_parent().get_parent().get_parent().get_node("ui_select")


#func _process(delta):
#	if $start.pressed:
#		ui_select.play()
#		yield(ui_select, "finished")
#		get_tree().change_scene("res://main.tscn")
#	elif $settings.pressed:
#		ui_select.play()
#		yield(ui_select, "finished")
#		get_tree().change_scene("res://Scenes/settings.tscn")
#	elif $help.pressed:
#		ui_select.play()
#		yield(ui_select, "finished")
#		get_tree().change_scene("res://Scenes/help.tscn")
#	elif $quit.pressed:
#		ui_select.play()
#		yield(ui_select, "finished")
#		get_tree().quit()

func _on_start_mouse_entered():
	ui_hover.play()

func _on_settings_mouse_entered():
	ui_hover.play()

func _on_help_mouse_entered():
	ui_hover.play()

func _on_quit_mouse_entered():
	ui_hover.play()



func _on_start_pressed():
	ui_select.play()
	yield(ui_select, "finished")
	get_tree().change_scene("res://main.tscn")
	
func _on_settings_pressed():
	ui_select.play()
	yield(ui_select, "finished")
	get_tree().change_scene("res://Scenes/settings.tscn")

func _on_help_pressed():
	ui_select.play()
	yield(ui_select, "finished")
	get_tree().change_scene("res://Scenes/help.tscn")

func _on_quit_pressed():
	ui_select.play()
	yield(ui_select, "finished")
	get_tree().quit()
