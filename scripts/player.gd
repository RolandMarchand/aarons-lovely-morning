extends KinematicBody1D

signal state_changed(state)
signal damaged

const EATING_PARTICLES_SCENE := preload("res://scenes/eating_particles.tscn")

enum STATE {NORMAL, ALTERNATE}

export(float, 0.1, 10) var speed = 100

var state = Food.TYPE.TACO
var health = 3
var disabled = true


func _unhandled_key_input(_event):
	if disabled:
		return
	
	if Input.is_action_just_pressed("taco"):
		change_state(Food.TYPE.TACO)
	if Input.is_action_just_pressed("pizza"):
		change_state(Food.TYPE.PIZZA)
	if Input.is_action_just_pressed("burrito"):
		change_state(Food.TYPE.BURRITO)


func change_state(s):
	if s == state:
		return
	
	state = s
	emit_signal("state_changed", state)


func _physics_process(delta):
	# warning-ignore:return_value_discarded
	move_and_collide(speed * delta)

func eat(_food: Food) -> void:
	$EatSound.pitch_scale = rand_range(0.9, 1.2)
	$EatSound.play()
	
	var particles = EATING_PARTICLES_SCENE.instance()
	$EatingParticlesPosition.add_child(particles)
	particles.emitting = true

func damage() -> void:
	health -= 1
	
	$Damaged.play("damaged")
	emit_signal("damaged")
	
