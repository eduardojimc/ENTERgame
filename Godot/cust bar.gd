extends ProgressBar

#linking with master script
func _physics_process(delta):
	value=masterVar.custValue
	max_value=masterVar.custmax
