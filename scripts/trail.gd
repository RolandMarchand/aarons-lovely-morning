tool
extends Line2D

const OFFSET := 2

export(int) var MAX_LENGTH := 12

func _physics_process(_delta):
	add_point(get_node("../Sprite").global_position)
	
	position.x = owner.global_position * -1 + OFFSET
	
	if points.size() > MAX_LENGTH: 
		remove_point(0)


func _init():
	add_timer()


func _on_Timer_timeout():
	if points.empty():
		return
		
	remove_point(0)


func add_timer() -> void:
	var timer = Timer.new()
	
	timer.one_shot = false
	timer.autostart = true
	timer.wait_time = 0.2
	timer.process_mode = Timer.TIMER_PROCESS_PHYSICS
	
	timer.connect("timeout", self, "_on_Timer_timeout")
	
	add_child(timer)
