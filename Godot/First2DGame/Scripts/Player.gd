extends KinematicBody2D


export var score : int = 0
export var speed : int = 50  # set to 100 if too slow
export var gravity : int = 800

# bullet stuff
export (PackedScene) onready var bullet_scene
export (NodePath) onready var bullet_spawn_path
export (float) var bullet_angle = 350 # setget set_bullet_angle
export (int) var bullet_speed = 8
export (int) var bullet_gravity = 5
export (float) var bullet_delay = 1 # seconds
onready var bullet_spawn = get_node(bullet_spawn_path)
var waited = 0
var directional_force = Vector2()
var shooting = false
var bounce = 0.3

var vel : Vector2 = Vector2()

var hasTurn : bool   = false
var moveLeft : bool  = false
var moveRight : bool = false
var fire_clicked : bool = false

var finishedTurn = false  # the turn finishes when the ball hits and/or finishes its animation

onready var tank : AnimatedSprite = get_node("tank")
var numOfMoves : int = 4

func _physics_process(delta):
	vel.x = 0
	
	# movement: left - right
	if hasTurn:
		if Input.is_action_pressed("move_left"):
			# moveLeft = true
			# moveRight = false
			vel.x -= speed
			tank.play("moveBackwards")
		elif Input.is_action_pressed("move_right"):
			# moveLeft = false
			# moveRight = true
			vel.x += speed
			tank.play("moveForward")
		else:
			# moveLeft = false
			# moveRight = false
			tank.stop()  # tank.play("idle") <- if no work
		
	
	# gravity
	vel.y += gravity * delta
	
	# applying velocity
	vel = move_and_slide(vel, Vector2.UP)
	
func _ready():	
	set_process_input(true)
	set_process(true)
	
func _process(delta):
	if hasTurn:
		check_fire_clicked()
		
		if shooting && (waited > bullet_delay):
			fire_once()
			waited = 0
		elif waited <= bullet_delay:
			waited += delta
	
func check_fire_clicked():
	if fire_clicked:
		print("fire!")
		shooting = fire_clicked

func update_directional_force():
	directional_force = Vector2(cos($tank/TankPipe.rotation), sin($tank/TankPipe.rotation)) * bullet_speed
	
func fire_once():
	shoot()
	shooting = false
	fire_clicked = false
	
func shoot():
	# create new instance of a bullet
	var bullet = bullet_scene.instance()
	update_directional_force()
	bullet.set_global_position(bullet_spawn.get_global_position())
	bullet.shoot(directional_force, bullet_gravity)
	get_parent().add_child(bullet)
	
	
	
	
	
	
	
	
	
	
	
	
	
