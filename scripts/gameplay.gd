# Aaron's Lovely Morning. Godot video game.
# Copyright (C) 2022 moowool195@gmail.com
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

extends Node1D

const FOOD_SCENE := preload("res://scenes/food.tscn")
const SPAWN_OFFSET := 425
const MAX_RANGE_LIMIT := 0.3
const RANGE_DICREASE := 0.007

export(Curve) var food_time_curve: Curve
var min_range: float = 0.3
var max_range: float = 1

var zen_mode := false

var rng := RandomNumberGenerator.new()

func _ready():
	rng.randomize()


func _on_Timer_timeout():
	add_food()
	set_timer_time()


func add_food() -> void:
	var food: Food = FOOD_SCENE.instance()
	
	food.type = rng.randi() % 3
	
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
