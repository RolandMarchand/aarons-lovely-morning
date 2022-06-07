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

class_name Food
extends Area1D

enum TYPE {TACO, PIZZA, BURRITO}

const SHADER := {
	TYPE.TACO: preload("res://resources/taco_food.gdshader"),
	TYPE.PIZZA: preload("res://resources/pizza_food.gdshader"),
	TYPE.BURRITO: preload("res://resources/burrito_food.gdshader"),
}
