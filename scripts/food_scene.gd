tool
extends Food

export(TYPE) var type = TYPE.TACO setget set_type

func set_type(t: int):
	var mat: ShaderMaterial = material
	mat.shader = SHADER[t]
	
	$Sprite.frame = t
	type = t


func _on_Food_body_entered(body: CanvasItem):
	if not body.is_in_group("player"):
		return
	
	if get_parent().zen_mode or body.state == type:
		body.eat(self)
	else:
		body.damage()
	$AnimationPlayer.play("eaten")
