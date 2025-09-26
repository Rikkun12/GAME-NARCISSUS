extends CharacterBody2D

var input
@export var speed = 100.0
@export var gravity = 10

#State Machine 
var current_state = player_states.MOVE
enum player_states{MOVE, SWORD}

#Variable for JUMP
var jump_count = 0
@export var max_jump = 2
@export var jump_force = 175

# Called when the node enters the scene tree for the first time.
func _ready():
	$sword/sword_collider.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	match current_state:
		player_states.MOVE:
			movement(delta)
		
		player_states.SWORD:
			sword(delta)
	
func movement(delta):
	input = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if input!=0:
		if input > 0:
			velocity.x += speed * delta
			velocity.x = clamp(speed, 75.0, speed)
			$Sprite2D.flip_h = false
			$anim.play("walk")
			$sword/sword_collider.position.x = 8.75
			
		if input < 0:
			velocity.x -= speed * delta
			velocity.x = clamp(-speed, 75.0, -speed)
			$Sprite2D.flip_h = true
			$anim.play("walk")
			$sword/sword_collider.position.x = -8.75

			
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
		
	if Input.is_action_just_pressed("attack"):
		current_state = player_states.SWORD
		

	gravity_force()
	move_and_slide()


func gravity_force():
	velocity.y += gravity

func sword(delta):
	$anim.play("attack")
	input_movement(delta)	
func input_movement(delta):
	input = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if input!=0:
		if input > 0:
			velocity.x += speed * delta
			velocity.x = clamp(speed, 75.0, speed)

		if input < 0:
			velocity.x -= speed * delta
			velocity.x = clamp(-speed, 75.0, -speed)
	if input==0:
		velocity.x = 0
	move_and_slide()
	
func reset_states():
	current_state = player_states.MOVE
