extends Label

onready var parent : HSlider = get_parent()


############## MAIN ################
#func _ready():
#	text = str(parent.value)

func _on_enemy_num_value_changed(value):
	text = str(parent.value)
