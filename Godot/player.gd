extends KinematicBody2D


var velocity = Vector2.ZERO
const maxspeed = 300
const gravity= 2#Vector2(0,1)

func _physics_process(delta):
	var inputVector = Vector2.ZERO
	
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	velocity.y =-gravity
	
	
	if inputVector != Vector2.ZERO:
		velocity = inputVector
	else:
		velocity = Vector2.ZERO
	
	move_and_collide(velocity*delta*maxspeed)
