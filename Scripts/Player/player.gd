extends CharacterBody2D

var input
@export var speed = 75.0
@export var gravity = 10

#Variable for JUMP
var jump_count = 0
@export var max_jump = 2
@export var jump_force = 250
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement(delta)
	
func movement(delta):
	input = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if input!=0:
		if input > 0:
			velocity.x += speed * delta
			velocity.x = clamp(speed, 75.0, speed)
			$Sprite2D.flip_h = false
			$anim.play("walk")
		if input < 0:
			velocity.x -= speed * delta
			velocity.x = clamp(-speed, 75.0, -speed)
			$Sprite2D.flip_h = true
			$anim.play("walk")
	if input==0:
		velocity.x = 0
		$anim.play("Idle")
		
#JUMP
	if is_on_floor():
		jump_count = 0
				
	if Input.is_action_pressed("jump") && is_on_floor() && jump_count < max_jump:
		jump_count += 1
		velocity.y -= jump_force
		velocity.x = input
		
	if  !is_on_floor() && Input.is_action_pressed("jump") && jump_count < max_jump:
		jump_count += 1
		velocity.y -= jump_force
		velocity.x = input
		
	if !is_on_floor() && Input.is_action_just_released("jump")  && jump_count < max_jump:
		velocity.y = gravity
		velocity.x = input
		 
	else:
		gravity_force()

	gravity_force()
	move_and_slide()


func gravity_force():
	velocity.y += gravity
