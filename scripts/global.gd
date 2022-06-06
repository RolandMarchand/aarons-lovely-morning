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
