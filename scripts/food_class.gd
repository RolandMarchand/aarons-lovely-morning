class_name Food
extends Area1D

enum TYPE {TACO, PIZZA, BURRITO}

const SHADER := {
	TYPE.TACO: preload("res://resources/taco_food.gdshader"),
	TYPE.PIZZA: preload("res://resources/pizza_food.gdshader"),
	TYPE.BURRITO: preload("res://resources/burrito_food.gdshader"),
}
