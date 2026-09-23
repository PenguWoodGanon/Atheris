extends Sprite2D

@onready var click = $Button
@onready var wall_art = $"../Player/Camera2D/WallArt"

var window_open = false

func _ready():
	wall_art.visible = false
	window_open = false

func _on_button_pressed():
	wall_art.visible = true
	window_open = true

func _process(delta):
	if window_open == true:
		if Input.is_action_just_pressed("escape"):
			wall_art.visible = false
			window_open = false
