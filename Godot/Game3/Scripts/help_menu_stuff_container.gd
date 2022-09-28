extends GridContainer

onready var ui_hover : AudioStreamPlayer = get_parent().get_parent().get_parent().get_node("ui_hover")
onready var ui_select : AudioStreamPlayer = get_parent().get_parent().get_parent().get_node("ui_select")

#func _process(delta):
#	if $back.pressed:
#		ui_select.play()
#		yield(ui_select, "finished")
#		get_tree().change_scene("res://Scenes/menu.tscn")


func _on_back_mouse_entered():
	ui_hover.play()


func _on_back_pressed():
	ui_select.play()
	yield(ui_select, "finished")
	get_tree().change_scene("res://Scenes/menu.tscn")
