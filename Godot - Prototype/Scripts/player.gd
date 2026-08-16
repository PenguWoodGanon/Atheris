extends CharacterBody2D

var SPEED = 500.0
const JUMP_VELOCITY = -500.0
var dashcount = 0

@onready var sprite_2d = $AnimatedSprite2D
@onready var dashtimer = $dashtimer

func _physics_process(delta):
	if is_on_floor():
		dashcount = 0
	#Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	#Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("shoot"):
		sprite_2d.play("shoot")

	#Left/Right
	var direction = Input.get_axis("left", "right")
	if Input.is_action_just_pressed("left"):
		sprite_2d.play("run")
	if Input.is_action_just_pressed("right"):
		sprite_2d.play("run")
	
	#Dash
	if Input.is_action_just_pressed("dash"):
		if is_on_floor():
			sprite_2d.play("dash")
			dashtimer.start()
			SPEED *= 8
			velocity.x = direction * SPEED
			print(dashcount)
		elif not is_on_floor() and dashcount == 0:
			sprite_2d.play("dash")
			dashcount += 1
			dashtimer.start()
			SPEED *= 8
			velocity.x = direction * SPEED
			print(dashcount)


	#Flip
	if direction > 0:
		sprite_2d.flip_h = false
	elif direction < 0:
		sprite_2d.flip_h = true
	elif direction == 0:
		sprite_2d.play("idle")dd

	# Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

#Reset Speed
func _on_dashtimer_timeout():
	sprite_2d.play("default")
	SPEED = 500.0
	
