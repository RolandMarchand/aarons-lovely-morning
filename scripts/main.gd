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

# warning-ignore-all:return_value_discarded
extends Node

enum {GAME, MENU}

const MAX_PULSES := 15
const PULSES := {
	Food.TYPE.TACO: preload("res://scenes/taco_pulse.tscn"),
	Food.TYPE.PIZZA: preload("res://scenes/pizza_pulse.tscn"),
	Food.TYPE.BURRITO: preload("res://scenes/burrito_pulse.tscn"),
}

onready var player: KinematicBody1D
onready var gameplay := $ViewportContainer/Viewport/Gameplay
onready var gui := $ViewportContainer/Viewport/GUI

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	player.connect("state_changed", self, "_on_Player_state_changed")
	player.connect("damaged", self, "_on_Player_damaged")
	player.connect("healed", self, "_on_Player_healed")
	player.connect("ate", self, "_on_Player_ate")
	
	gui.get_node(@"GameOver/Buttons/Restart").connect("pressed", self, "_on_Restart_pressed")
	gui.get_node(@"GameOver/Buttons/MainMenu").connect("pressed", self, "_on_Restart_pressed")
	
	if Global.state == Global.STATE_GAME:
		$Tooltip.start()
	
	if Global.high_score != 0:
		gui.get_node(@"Menu/HighScore/Label").text = "High Score: " + str(Global.high_score)


func _unhandled_key_input(_event):
	if Global.state != Global.STATE_GAME:
		return
	
	if Input.is_action_just_pressed("pause") and not Global.lost:
		if get_tree().paused:
			get_tree().paused = false
			gui.hide_paused()
		else:
			get_tree().paused = true
			gui.show_paused()
		
		return
	
	if $AnimationPlayer.is_playing():
		return
	
	if gameplay.is_started():
		return
	
	var zen = Input.is_action_just_pressed("zen_mode")
	var pizza = Input.is_action_just_pressed("pizza")
	var burrito = Input.is_action_just_pressed("burrito")
	if zen or pizza or burrito:
		gameplay.zen_mode = zen
		gameplay.start()
		if not zen:
			gui.show_lives()
		# Skipping Taco because it has no feedback
		if pizza:
			player.change_state(Food.TYPE.PIZZA)
		elif burrito:
			player.change_state(Food.TYPE.BURRITO)
	else:
		return
	
	if $Tooltip.is_stopped():
		gui.hide_tooltip()
	
	$Tooltip.stop()


func _on_Player_state_changed(state):
	var pulse_scene = PULSES.get(state)
	assert(pulse_scene)
	
	var pulse = pulse_scene.instance()
	pulse.global_position = Vector2(171, 108) * 8
	
	if $Pulses.get_children().size() > MAX_PULSES:
		$Pulses.remove_child($Pulses.get_child(0))
		
	$Pulses.add_child(pulse)


func _on_Player_damaged():
	gui.get_node(@"Lives").value = player.health
	
	if player.health > 0:
		return
	
	get_tree().paused = true
	Global.lost = true
	
	if player.score > Global.high_score:
		Global.high_score = player.score
		Global.save()
	
	$AnimationPlayer.play("game_over")


func _on_Player_healed():
	gui.get_node(@"Lives").value = min(player.health, player.MAX_HEALTH)


func _on_Player_ate():
	gui.get_node(@"Lives/Score").text = str(player.score)


func _on_Restart_pressed():
	$AnimationPlayer.play("close")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "close":
		get_tree().paused = false
		Global.lost = false
		get_tree().change_scene("res://scenes/main.tscn")
