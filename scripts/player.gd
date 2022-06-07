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

extends KinematicBody1D

signal state_changed(state)
signal damaged
signal healed
signal ate

const EATING_PARTICLES_SCENE := preload("res://scenes/eating_particles.tscn")

const DEFAULT_SPEED := 100
const MAX_SPEED := 150
const SPEED_INCREASE := 1
const MIN_SCORE_TO_INCREASE_SPEED := 70
const HEAL_FREQUENCY := 40
const MAX_HEALTH := 3

enum STATE {NORMAL, ALTERNATE}

export(int, 0, 200) var speed = DEFAULT_SPEED
export(bool) var invincible = false # Managed in the Damaged animation player

var state = Food.TYPE.TACO
var health = MAX_HEALTH
var disabled = true
var score = 0


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
	
	score += 1
	if score > MIN_SCORE_TO_INCREASE_SPEED:
		speed = min(speed + SPEED_INCREASE, MAX_SPEED)
	
	if score % HEAL_FREQUENCY == 0 and health < MAX_HEALTH:
		health += 1
		$HealthChanged.play("healed")
		emit_signal("healed")
	
	emit_signal("ate")


func damage() -> void:
	if invincible:
		return
	
	health -= 1
	
	$Pause.start()
	speed = 0
	
	$HealthChanged.play("damaged")
	emit_signal("damaged")


func _on_Pause_timeout():
	speed = DEFAULT_SPEED
