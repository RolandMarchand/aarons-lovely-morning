extends Node1D

const FOOD_SCENE := preload("res://scenes/food.tscn")
const SPAWN_OFFSET := 425

func _ready():
	randomize()


func _on_Timer_timeout():
	var food: Food = FOOD_SCENE.instance()
	food.type = randi() % 3
	add_child(food)
	food.position = $Player/Spawn.global_position


func start() -> void:
	$Player.disabled = false
	$Timer.start()


func is_started() -> bool:
	return not $Player.disabled
