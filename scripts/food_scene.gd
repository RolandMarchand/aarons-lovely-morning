tool
extends Food

const TIP := {
	TYPE.TACO: "1",
	TYPE.PIZZA: "2",
	TYPE.BURRITO: "3",
}

export(TYPE) var type = TYPE.TACO setget set_type

var show_tip := true


func set_type(t: int):
	material.shader = SHADER[t]
	
	$Sprite.frame = t
	type = t


func _ready():
	$Sprite/Tip.text = TIP.get(type, "")


func _on_Food_body_entered(body: CanvasItem):
	if not body.is_in_group("player"):
		return
	
	if get_parent().zen_mode or body.state == type:
		body.eat(self)
	else:
		body.damage()
	$AnimationPlayer.play("eaten")
