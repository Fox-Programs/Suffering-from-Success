extends Node

var game_time = 0.0
var timer_active = false

var player_life = 0
var player_attack = 0
var probability_attack_player = 1.0
var luck = 0
var regeneration = 0
var max_player_life = 1

var enemie_attack = 0
var enemie_life = 0
var probability_attack_enemie = 0.2
var nb_enemie = 0

var difficulty = ""

const MIN_PLAYER_ATTACK = 0.01
const MIN_PLAYER_PROBABILITY_ATTACK = 0.1
const MAX_NB_ENNEMIES = 15

var ennemies_spawn = {
	"ninja" : true,
	"boat" : false,
	"knight" : false,
	"long helmet" : false,
	"coocker" : false,
	"insect" : false,
	"flame" : false,
	"croc" : false
}

signal create_totem
signal open_menu_debuff
signal close_menu_debuff
signal reset
signal explosion
signal click
signal tap

func _ready():
	reset.connect(reset_all)

func _process(delta):
	if timer_active:
		game_time += delta

func start_timer():
	timer_active = true

func stop_timer():
	timer_active = false

func reset_timer():
	game_time = 0.0

func easy():
	ennemies_spawn['boat'] = true
	player_life = 1000
	player_attack = 10
	luck = 75
	regeneration = 10
	enemie_attack = 10
	enemie_life = 100
	probability_attack_enemie = 1
	nb_enemie = 10
	max_player_life = player_life
	difficulty = "easy"
	
func medium():
	player_life = 2500
	player_attack = 7
	luck = 50
	regeneration = 100
	enemie_attack = 7
	enemie_life = 50
	probability_attack_enemie = 0.5
	nb_enemie = 5
	max_player_life = player_life
	difficulty = "medium"
	
func hard():
	player_life = 10000
	player_attack = 4
	luck = 25
	regeneration = 1000
	enemie_attack = 4
	enemie_life = 20
	probability_attack_enemie = 0.3
	nb_enemie = 2
	max_player_life = player_life
	difficulty = "hard"
	
func extreme():
	player_life = 100000
	player_attack = 1
	luck = 5
	regeneration = 5000
	enemie_attack = 1
	enemie_life = 5
	probability_attack_enemie = 0.1
	nb_enemie = 0
	max_player_life = player_life
	difficulty = "extreme"
	
func reset_all():
	game_time = 0.0
	timer_active = false

	player_life = 0
	player_attack = 0
	probability_attack_player = 1.0
	luck = 0
	regeneration = 0
	max_player_life = 1

	enemie_attack = 0
	enemie_life = 0
	probability_attack_enemie = 0.2
	nb_enemie = 0

	difficulty = ""

	ennemies_spawn = {
		"ninja" : true,
		"boat" : false,
		"knight" : false,
		"long helmet" : false,
		"coocker" : false,
		"insect" : false,
		"flame" : false,
		"croc" : false
	}
	
	
	
