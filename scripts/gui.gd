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

extends CanvasLayer

signal start

func _ready():
	if Global.state == Global.STATE_MENU:
		$Menu.show()
	
	$Menu/Options/Sound/Slider.value = db2linear(AudioServer.get_bus_volume_db(0))
	
	if OS.get_name() == "HTML5":
		$GameOver/Buttons/Quit.hide()
		$Menu/Main/Quit.hide()


func show_game_over() -> void:
	$GameOver/AnimationPlayer.play("game_over")


func show_tooltip() -> void:
	$Tooltip/AnimationPlayer.play("show")
	yield(get_tree().create_timer(5.0), "timeout")
	if $Tooltip.modulate == Color.white:
		hide_tooltip()


func hide_tooltip() -> void:
	$Tooltip/AnimationPlayer.queue("hide")


func show_lives() -> void:
	$Lives/AnimationPlayer.play("show")


func hide_lives() -> void:
	$Lives/AnimationPlayer.play("hide")


func show_paused() -> void:
	$Paused/AnimationPlayer.play("show")


func hide_paused() -> void:
	$Paused/AnimationPlayer.play("hide")


func _on_ReallyQuit_pressed():
	get_tree().quit(0)


func _on_Play_pressed():
	$Menu/AnimationPlayer.play("hide")
	Global.state = Global.STATE_GAME
	emit_signal("start")


func _on_Fullscreen_pressed():
	OS.window_fullscreen = not OS.window_fullscreen


func _on_Slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, linear2db(value))


func _on_Unpause_pressed():
	get_tree().paused = false
	$Paused/AnimationPlayer.play("hide")


func _on_MainMenu_pressed():
	Global.state = Global.STATE_MENU
