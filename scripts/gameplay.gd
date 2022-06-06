extends Node1D

const FOOD_SCENE := preload("res://scenes/food.tscn")
const SPAWN_OFFSET := 425
const MAX_RANGE_LIMIT := 0.3
const RANGE_DICREASE := 0.007

export(Curve) var food_time_curve: Curve
onready var min_range: float = 0.3
onready var max_range: float = 1

var zen_mode := false

var rng := RandomNumberGenerator.new()

func _ready():
	rng.randomize()


func _on_Timer_timeout():
	add_food()
	set_timer_time()


func add_food() -> void:
	var food: Food = FOOD_SCENE.instance()
	
	food.type = randi() % 3
	
	if zen_mode:
		food.material = Food.SHADER[Food.TYPE.TACO]
		
	add_child(food)
	food.position = $Player/Spawn.global_position


func set_timer_time() -> void:
	var val = rng.randf_range(min_range, max_range)
	
	$NextFoodTimer.wait_time = food_time_curve.interpolate(val)
	
	max_range = max(max_range - RANGE_DICREASE, MAX_RANGE_LIMIT)
	min_range = max(0, min_range - RANGE_DICREASE)


func start() -> void:
	$Player.disabled = false
	$NextFoodTimer.start()


func is_started() -> bool:
	return not $Player.disabled
