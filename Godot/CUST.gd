extends Control
func _input(event):
	if event.is_action_pressed("CUST"):
		if (masterVar.CUSTfull):
			var newpausestate = not get_tree().paused
			get_tree().paused =newpausestate
			visible =newpausestate 
