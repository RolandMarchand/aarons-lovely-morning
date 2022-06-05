extends CanvasLayer

signal start

func _ready():
	if Global.state == Global.STATE_MENU:
		$Menu.show()
	
	$Menu/Options/Sound/Slider.value = db2linear(AudioServer.get_bus_volume_db(0))


func show_game_over() -> void:
	$GameOver/AnimationPlayer.play("game_over")


func show_tooltip() -> void:
	$Tooltip/AnimationPlayer.play("show")


func hide_tooltip() -> void:
	$Tooltip/AnimationPlayer.queue("hide")


func show_lives() -> void:
	$Lives/AnimationPlayer.play("show")


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
