extends KinematicBody2D

var enemy_type : int

onready var starting_pos : Vector2 = position
onready var speed : int = 1

onready var engine_sfx : Array = [$moped_engine_sfx, $truck_engine_sfx, $car_engine_sfx]
onready var honk_sfx : Array = [$moped_honk_sfx, $truck_honk_sfx, $car_honk_sfx]

export var disabled : bool = false

var starting_delay = 0
var counter = 0

var honk_or_not : bool = false
var beg_ticks = OS.get_ticks_msec()
var honk_delay = (randi() % 20) * 1000

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	init()

func _process(delta):
	var current_ticks = OS.get_ticks_msec()
	if current_ticks - beg_ticks >= honk_delay:
		honk_or_not = randi() % 2
		if honk_or_not:
			honk()
		honk_delay = (randi() % 7) * 1000
		beg_ticks = current_ticks

func init():
	if disabled:
		hide()
	else:
		show()
		init_enemy()

func change_skin():
	enemy_type = randi() % 3
	
	match (enemy_type):
		0: 
			$sprite.play("moped")
			$sprite.stop()
			change_collision_shape(false, true, true)
		1: 
			$sprite.play("truck")
			$sprite.stop()
			change_collision_shape(true, false, true)
		2: 
			$sprite.play("car")
			$sprite.stop()
			change_collision_shape(true, true, false)

func honk():
	honk_sfx[enemy_type].play()

func change_collision_shape(moped : bool, truck : bool, car : bool):
	# false => enable collision
	# true  => disable collision
	
	$moped_collision.disabled = moped
	$truck_collision.disabled = truck
	$car_collision.disabled = car
	
func init_enemy_spawn():
	var spawn_collision = get_parent().get_child(1)
	var spawn_width = spawn_collision.shape.extents
	var spawn_center = spawn_collision.position
	var x_high : float = spawn_center.x + spawn_width.x
	var x_low : float = spawn_center.x - spawn_width.x
	var y_high : float = spawn_center.y + spawn_width.y
	var y_low : float = spawn_center.y - spawn_width.y
	
	
	var x = rand_range(x_high, x_low)
	var y = rand_range(y_high, y_low)
	
	position = Vector2(x, y)
	starting_pos = position
	
func init_enemy():
	starting_delay = rand_range(5, 20)
	counter = 0
	change_skin()
	init_enemy_spawn()
	engine_sfx[enemy_type].play()

func _physics_process(delta):
#	if counter >= starting_delay:
#		position.y += speed
#	else: counter += 1
	position.y += speed

func _on_visibility_notifyer_screen_exited():
	# engine_sfx[enemy_type].stop()
	position = starting_pos
	init_enemy()
