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
