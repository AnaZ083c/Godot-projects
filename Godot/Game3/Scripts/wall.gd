extends KinematicBody2D

var reset_y = -48
export var speed = 0.5

func _physics_process(delta):
	position.y += speed
	
	if position.y > get_viewport().size.y + $sprite.texture.get_size().y/2:
		position.y = reset_y

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
