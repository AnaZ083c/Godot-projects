extends Sprite

var mousePos = 0
var corsair_grabbed : bool = false
var grabbed_offset : Vector2 = Vector2()
var corsair_mouse = load("res://Assets/Sprites/corsair-2.png")

onready var corsair : Sprite = get_node(".")
onready var player : KinematicBody2D = get_parent().get_parent().get_parent()
onready var hasTurn : bool = player.get("hasTurn")
onready var changeDeg : bool = get_parent().get("changeDeg")

func _input(event):
	if event is InputEventMouseButton:
		corsair_grabbed = event.pressed

func _process(delta):
	hasTurn = player.get("hasTurn")
	changeDeg = get_parent().get("changeDeg")
	
	if hasTurn:
		if changeDeg:
			Input.set_custom_mouse_cursor(corsair_mouse)
			corsair.hide()
		else:
			Input.set_custom_mouse_cursor(null)
			corsair.show()
	
	else:
		corsair.hide()
		# position = get_global_mouse_position() + grabbed_offset
