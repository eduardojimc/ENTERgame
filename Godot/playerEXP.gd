extends KinematicBody2D


var velocity = Vector2.ZERO
const maxspeed = 3000
var runSpeed = 4000
var gravity
var friction =300
var directionLR=0
var inputvector = Vector2.ZERO
var moveing

#dash
var boost = Vector2.ZERO
var boostRate =100
var boostMax= 100
var boostFric = 1
var boostStart = 60

var dashCDvalue =0
var dashCDrate =1
var dashCDmax =0.25
var dashTrue=false
var dashAbs= Vector2.ZERO
#jump stuff
var jumpspeed
export (float) var timeToJumpPeak = .5
export (int) var JumpHeight =50
var jumpNO
var jumpMAX=2

func _ready():
	gravity= (2*JumpHeight)/pow(timeToJumpPeak,2)
	jumpspeed = gravity* timeToJumpPeak

func _physics_process(delta):
	
	if(is_on_floor()):#floorcheck
		velocity.y= 1
		jumpNO=jumpMAX
	else: #gravityonPlayer
		velocity.y +=gravity * delta
	jump()#jump
	
	#inputvector defined
	inputvector.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	
	#flipping
	flipCHECK(inputvector, 1,false)
	flipCHECK(inputvector,-1,true)
	
	#define direction
	if(inputvector.x !=0):
		if(inputvector.x<0):
			directionLR=-1
		else:
			directionLR=1
	
	#X movement
	if inputvector!= Vector2.ZERO: #if input equal zero
		inputvector+= inputvector*runSpeed*delta 
	else:#inputvector/xMovement move tward zero at friction rate
		inputvector= inputvector.move_toward(Vector2.ZERO,friction*delta)
	
	#defining moving variable, combining the X from inputvector and Y from Velocity
	moveing = Vector2(inputvector.x, velocity.y)
	
	#dash
	
	
	dash(delta)

	print("boost",dashCDvalue)
	
	
	
	
	
	dashAbs=boost*directionLR
	#end of boost
	moveing=move_and_slide((moveing+dashAbs),Vector2.UP)

func jump():
	if (Input.is_action_just_pressed("space")):
		if(jumpNO>0):
			velocity.y = -jumpspeed
			jumpNO-=1

func Flip(boolean):
	$Sprite.flip_h=boolean

func flipCHECK(LEFTRIGHT,direction,boolean):
	
	if (LEFTRIGHT == Vector2(direction,0)):
		 Flip(boolean)

func dash(delta):
	if(Input.is_action_just_pressed("dash")):
		if(is_on_floor()):
			print("oh")
			boost.x=boostStart
			dashTrue=true
			dashCDvalue= dashCDmax
	
	if(Input.is_action_pressed("dash")):
		print("wow")
		if(dashCDvalue>0):
			
			if(boost.x<boostMax):
				boost.x*=boostRate*delta
		print(boost.x*boostRate*delta)
		
	
	if(Input.is_action_just_released("dash")):
		print("fuck")
		dashTrue=false
		
	
	if(dashTrue==true):
		$normalColi.disabled= false
		$dashColi.disabled=true
	else:
		$normalColi.disabled= true
		$dashColi.disabled=false
	
	
	boost.x -= friction*delta
	
	
	if(boost.x<0):
		boost.x=0
	
	dashCDvalue-=dashCDrate*delta
	
