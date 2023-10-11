extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		var newpausestate = not get_tree().paused
		get_tree().paused =newpausestate
		visible =newpausestate
		print("damn")
