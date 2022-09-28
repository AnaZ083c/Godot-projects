extends KinematicBody2D

# PLAYER
export (int) var speed = 100
var move = Vector2()

# BULLET
export (int) var bullet_speed = 8
export (int) var bullet_gravity = 5

export (float) var bullet_delay = 0.5
export (PackedScene) onready var bullet_scene
export (NodePath) onready var bullet_spawn_path
onready var bullet_spawn = get_node(bullet_spawn_path)
var shooting = false
var waited = 0
var directional_force = Vector2()

func _physics_process(delta):
	move.x = 0
	
	if Input.is_action_pressed("left"):  # when pressed ENTER
		move.x -= speed
	elif Input.is_action_pressed("right"):
		move.x += speed
	
	move_and_slide(move)

func _process(delta):
	if shooting && waited > bullet_delay:
		shoot()
		waited = 0
	elif waited <= bullet_delay:
		waited += delta

func _input(event):	
	if event.is_action_pressed("fire"):
		shooting = true
	elif event.is_action_released("fire"):
		shooting = false
	

func _ready():
	update_directional_force()
	
	set_process_input(true)
	set_process(true)
	

func update_directional_force():
	directional_force = Vector2(cos($tank/pipe.rotation), sin($tank/pipe.rotation)) * bullet_speed

func shoot():
	update_directional_force()
	var bullet = bullet_scene.instance()
	bullet.set_global_position(bullet_spawn.get_global_position())
	bullet.set_global_rotation($tank/pipe.rotation)
	print(bullet.get_global_transform().get_rotation())
	bullet.shoot(directional_force, bullet_gravity)
	get_parent().add_child(bullet)
