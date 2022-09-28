extends KinematicBody2D

#export (PackedScene) var player_1
#export (PackedScene) var player_2

var _gravity = 0
var _movement = Vector2()

var bounce = 0.3

func shoot(directional_force, gravity):
	# look_at(get_global_mouse_position())
	_movement = directional_force
	_gravity = gravity
	set_physics_process(true)
	
func update_rotation(_rotation):
	rotation_degrees = _rotation
	
func _physics_process(delta):
	_movement.y += delta * _gravity
	var collision = move_and_collide(_movement)

	if collision:
		var entity = collision.collider.name
		var normal = collision.normal
		_movement = (_movement - 2 * _movement.dot(normal) * normal) * bounce

	move_and_slide(_movement)


func _on_visibility_notifier_screen_exited():
	pass
	# queue_free()
