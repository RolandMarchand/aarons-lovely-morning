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
