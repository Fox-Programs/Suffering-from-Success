extends CanvasLayer


@onready var barre_noire = $Control/Background
@onready var barre_rouge = $Control/Background/Life
@onready var label = $Control/Background/Life/Label

const largeur_max = 300

func _ready() -> void:
	barre_noire.size.x = largeur_max

func _process(_delta):
	# Calcul du ratio de vie (entre 0.0 et 1.0)
	var health_ratio = float(Global.player_life) / Global.max_player_life
	
	# On ajuste la largeur du rectangle rouge
	barre_rouge.size.x = largeur_max * health_ratio
	
	if health_ratio < 0.2:
		label.text = ""
	else :
		label.text = "Life"
