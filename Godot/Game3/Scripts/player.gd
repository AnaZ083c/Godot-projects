extends KinematicBody2D

export var speed : int = 50
var new_position : Vector2 = Vector2()
onready var old_position : Vector2 = position

var mouse_motion = false

export onready var game_over : bool = false

func _ready():
	$car_explosion.hide()
	$car_explosion.stop()
	$car.show()
	pause_mode = Node.PAUSE_MODE_PROCESS
	position = Vector2(get_viewport().size.x / 2, get_viewport().size.y - $car.texture.get_size().y - 20)

func _physics_process(delta):
	old_position = position
	
	new_position.x = 0
	new_position.y = 0
	
	# mouse movement
#	if Input.is_mouse_button_pressed(1) && InputEventMouseMotion:
#		new_position = get_local_mouse_position()
#
#	# keyboard
#	else:
	# X axis
	if Input.is_action_pressed("ui_left"):
		new_position.x -= speed
	if Input.is_action_pressed("ui_right"):
		new_position.x += speed
	
	# Y axis
	if Input.is_action_pressed("ui_down"):
		new_position.y += speed
	if Input.is_action_pressed("ui_up"):
		new_position.y -= speed
	
	if not game_over:
		$engine_sfx.play()
		move_and_slide(new_position)
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			var entity_name = collision.collider.name
			game_over = "enemy" in entity_name
				
		# check if out of bounds or not
		if (position.y < $car.texture.get_size().y) or (position.y > get_viewport().size.y - $car.texture.get_size().y):
			position.y = old_position.y
			
func _input(event):
	if Input.is_action_just_pressed("honk"):
		$honk_sfx.play()
