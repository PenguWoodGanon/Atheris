extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -500.0

@onready var sprite_2d = $Sprite2D

func _physics_process(delta):
	#Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	#Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#Left/Right
	var direction = Input.get_axis("left", "right")

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
