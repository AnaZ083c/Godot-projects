extends Node2D

"""
blueTurn --> false => red
blueTurn --> true  => blue
"""
onready var blueTurn : bool = true
export var maxMoves : int = 4

onready var player1 : KinematicBody2D = get_node("Player1")
onready var player2 : KinematicBody2D = get_node("Player2")
onready var p1TankPipe : Sprite = get_node("Player1/tank/TankPipe")
onready var p2TankPipe : Sprite = get_node("Player2/tank/TankPipe")
onready var p1Corsair : Sprite = get_node("Player1/tank/TankPipe/Corsair")
onready var p2Corsair : Sprite = get_node("Player2/tank/TankPipe/Corsair")
onready var buttonFire : TextureButton = get_node("Control/FireButton")
onready var buttonDeg : TextureButton = get_node("Control/Degrees")

var firePressed : int = 0
var degPressed : int = 0

var changeDeg : bool = false
			
			
func _on_button_pressed(button, counter):
	if button.pressed:
		counter += 1
	else:
		counter = 0
		
	return counter

func _on_fire_pressed():
	firePressed = _on_button_pressed(buttonFire, firePressed)
	if firePressed == 1:
		# TODO: first shoot, then change turns
		if blueTurn: 
			player1.set("fire_clicked", true)
		else: 
			player2.set("fire_clicked", true)
			
		blueTurn = not blueTurn
		

func _on_deg_pressed():
	degPressed = _on_button_pressed(buttonDeg, degPressed)
	if degPressed == 1:
		changeDeg = true
		if blueTurn:
			Input.warp_mouse_position(p1Corsair.position)
		else:
			Input.warp_mouse_position(p2Corsair.position)
		
	if blueTurn:
		p1TankPipe.set("changeDeg", changeDeg)
	else:
		p2TankPipe.set("changeDeg", changeDeg)
	
	if not buttonDeg.pressed and Input.is_mouse_button_pressed(BUTTON_LEFT):
		changeDeg = false
		p1TankPipe.set("changeDeg", changeDeg)
		p2TankPipe.set("changeDeg", changeDeg)
		Input.set_custom_mouse_cursor(null)

func _process(delta):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	# _on_button_pressed(buttonFire, firePressed)
	_on_fire_pressed()
	_on_deg_pressed()
	
	if blueTurn:
		print("BLUE")
		player1.set("hasTurn", true)
		player2.set("hasTurn", false)
	else:
		print("RED")
		player1.set("hasTurn", false)
		player2.set("hasTurn", true)
