extends Sprite

var mousePos = 0
var grabbed_offset : Vector2 = Vector2()

# onready var tankPipe : Sprite = get_node(".")
onready var corsair : Sprite = get_node("Corsair")
onready var player : KinematicBody2D = get_parent().get_parent()
onready var hasTurn : bool = player.get("hasTurn")

var changeDeg : bool = false

func _process(delta):
	hasTurn = player.get("hasTurn")
	
	if hasTurn and changeDeg:
		mousePos = get_global_mouse_position()
		if not corsair.visible:
			look_at(mousePos)
