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

extends Node

enum {STATE_GAME, STATE_MENU}

const PASSWORD := "https://www.furaffinity.net/view/46573984/"
const SAVE_DIR := "user://save.cfg"

var state = STATE_MENU
var round_count: int = 1

var lost := false
var high_score: int = 0

func _ready():
	var cfg = ConfigFile.new()
	var err = cfg.load_encrypted_pass(SAVE_DIR, PASSWORD)
	
	if err != OK:
		return
	
	high_score = cfg.get_value("Stats", "High Score", 0)

func save():
	var cfg = ConfigFile.new()
	
	cfg.set_value("Stats", "High Score", high_score)
	
	cfg.save_encrypted_pass(SAVE_DIR, PASSWORD)
