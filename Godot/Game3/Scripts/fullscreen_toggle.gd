extends Label

func _ready():
	$fullscreen.pressed = OS.window_maximized

func _on_fullscreen_toggled(button_pressed):	
	OS.window_maximized = button_pressed
	OS.window_borderless = button_pressed
	
	if button_pressed:
		OS.window_size = OS.get_screen_size()
		OS.window_position = Vector2(0, 0)
	else:
		OS.window_size = Vector2(1024, 600)
		OS.center_window()
