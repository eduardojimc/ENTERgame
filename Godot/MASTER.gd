extends Node
#cust variables
var custValue =0
var custRate=20
var CUSTfull =false
var custmax =100
func _physics_process(delta):
	
	#cust bar value stuff
	custValue += custRate*delta
	if(custValue==custmax):
		CUSTfull = true
	else:
		CUSTfull= false
	
