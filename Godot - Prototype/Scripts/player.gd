extends CharacterBody2D

var SPEED = 500.0
const JUMP_VELOCITY = -500.0

@onready var sprite_2d = $Sprite2D
@onready var dashtimer = $dashtimer

func _physics_process(delta):
	#Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	#Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#Left/Right
	var direction = Input.get_axis("left", "right")
	
	#Dash
	if Input.is_action_just_pressed("dash"):
		dashtimer.start()
		SPEED *= 8
		velocity.x = direction * SPEED
	
	#Flip
	if direction > 0:
		sprite_2d.flip_h = false
	elif direction < 0:
		sprite_2d.flip_h = true

	# Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_dashtimer_timeout():
	#Reset Speed
	SPEED = 500.0
