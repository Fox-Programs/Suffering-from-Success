extends CanvasLayer

# 1. On déclare les variables ici pour qu'elles soient accessibles partout
@onready var label_1 = $"Panel/animated_choice/VBoxContainer2/Contour 1/Label Choice"
@onready var label_2 = $"Panel/animated_choice/VBoxContainer2/Contour 2/Label Choice"
@onready var label_3 = $"Panel/animated_choice/VBoxContainer2/Contour 3/Label Choice"
@onready var all_effects = {
	"common": effect_dict_common,
	"rare": effect_dict_rare,
	"epic": effect_dict_epic,
	"legendary": effect_dict_legendary
	}


func _ready() -> void:
	pick_random_effects()


var effect_dict_common = {
	1 : "life enemies +",
	2 : "speed attack player -",
	3 : "speed attack enemies +",
	4 : "nb enemies +",
	5 : "damage player -",
	6 : "damage enemies +",
	7 : "luck +",
	8 : "regeneration -"
}

var effect_dict_rare = {
	1 : "life enemies ++",
	2 : "speed attack player --",
	3 : "speed attack enemies ++",
	4 : "nb enemies ++",
	5 : "damage player --",
	6 : "damage enemies ++",
	7 : "luck ++",
	8 : "regeneration --",
	9 : "nb totem +"
}

var effect_dict_epic = {
	1 : "life enemies +++",
	2 : "speed attack player ---",
	3 : "speed attack enemies +++",
	4 : "nb enemies +++",
	5 : "damage player ---",
	6 : "damage enemies +++",
	7 : "luck +++",
	8 : "regeneration ---",
	9 : "nb totem ++",
	10 : "new_enemy spawn"
}

var effect_dict_legendary = {
	1 : "doubled life enemies",
	2 : "destroy speed attack player",
	3 : "doubled speed attack enemies",
	4 : "destroy damage player",
	5 : "doubled damage enemies",
	6 : "doubled luck",
	7 : "destroy regeneration",
	8 : "new_enemy spawn"
}

func get_random_rarity() -> String:
	var roll = randf() * 100
	var luck = Global.luck
	if 80 + roll < (luck):
		return "legendary"
	elif 50 + roll < (luck):
		return "epic"
	elif 20 + roll < (luck):
		return "rare"
	else:
		return "common"

# On va stocker des dictionnaires : {"rarity": "common", "id": 1}
var current_choices = []

func pick_random_effects():
	current_choices.clear()
	var labels = [label_1, label_2, label_3]
	
	for i in range(3):
		var rarity
		var random_id
		var is_duplicate = true
		
		# On boucle tant qu'on n'a pas trouvé un choix unique
		while is_duplicate:
			rarity = get_random_rarity()
			var pool = all_effects[rarity]
			var keys = pool.keys()
			random_id = keys[randi() % keys.size()]
			
			# On vérifie si cette combinaison existe déjà dans current_choices
			is_duplicate = false # On part du principe que c'est bon
			for choice in current_choices:
				if choice["rarity"] == rarity and choice["id"] == random_id:
					is_duplicate = true 
					break
		
		# Une fois sorti du while, on est sûr que le choix est unique
		current_choices.append({"rarity": rarity, "id": random_id})
		
		# On affiche le texte
		var final_pool = all_effects[rarity]
		labels[i].text = final_pool[random_id]
		set_label_color(labels[i], rarity)

func set_label_color(label, rarity):
	match rarity:
		"common": label.modulate = Color.GREEN
		"rare": label.modulate = Color.ORANGE_RED
		"epic": label.modulate = Color.MEDIUM_PURPLE
		"legendary": label.modulate = Color.GOLDENROD
		
func apply_effect(index):
	var choice = current_choices[index]
	var rarity = choice["rarity"]
	var id = choice["id"]
	
	# Utilisation combinée de la rareté et de l'ID
	match rarity:
		"common":
			match id:
				1 : Global.enemie_life += 1
				2 : minus_attack_probability_player(0.01)
				3 : Global.probability_attack_enemie += 1
				4 : Global.nb_enemie += 1
				5 : minus_damage_player(1)
				6 : Global.enemie_attack += 1
				7 : Global.luck += 1
				8 : minus_regeneration(1)
		"rare":
			match id:
				1 : Global.enemie_life += 5
				2 : minus_attack_probability_player(0.05)
				3 : Global.probability_attack_enemie += 5
				4 : Global.nb_enemie += 3
				5 : minus_damage_player(5)
				6 : Global.enemie_attack += 5
				7 : Global.luck += 5
				8 : minus_regeneration(5)
				9 : multiple_signal_totem(1)
		"epic":
			match id:
				1 : Global.enemie_life *= 1.3
				2 : minus_attack_probability_player(0.25 * Global.probability_attack_player)
				3 : Global.probability_attack_enemie *= 1.3
				4 : Global.nb_enemie += 5
				5 : minus_damage_player(0.25 * Global.player_attack)
				6 : Global.enemie_attack *= 1.3
				7 : Global.luck *= 1.3
				8 : minus_regeneration(0.25 * Global.regeneration)
				9 : multiple_signal_totem(2)
				10 : add_new_enemy()
		"legendary":
			match id:
				1 : Global.enemie_life *= 2
				2 : minus_attack_probability_player(0.5 * Global.probability_attack_player)
				3 : Global.probability_attack_enemie *= 2
				4 : minus_damage_player(0.5 * Global.player_attack)
				5 : Global.enemie_attack *= 2
				6 : Global.luck *= 2
				7 : minus_regeneration(0.5 * Global.regeneration)
				8 : add_new_enemy()
				

	get_tree().paused = false
	Global.start_timer()
	queue_free()
	
func multiple_signal_totem(amount : int) -> void :
	for i in range(amount) :
		Global.create_totem.emit()
		
func minus_attack_probability_player(amount : float) -> void :
	Global.probability_attack_player -= amount
	if Global.probability_attack_player < Global.MIN_PLAYER_PROBABILITY_ATTACK :
		Global.probability_attack_player = Global.MIN_PLAYER_ATTACK

func minus_damage_player(amount : int) -> void :
	Global.player_attack -= amount
	if Global.player_attack < Global.player_attack :
		Global.player_attack = Global.player_attack

func minus_regeneration(amount : int) -> void :
	Global.regeneration -= amount
	if Global.regeneration < 0 :
		Global.regeneration = 0
		
func add_new_enemy() -> void :
	if Global.ennemies_spawn["boat"] == false :
		Global.ennemies_spawn["boat"] = true
	elif Global.ennemies_spawn["knight"] == false :
		Global.ennemies_spawn["knight"] = true
	elif Global.ennemies_spawn["long helmet"] == false :
		Global.ennemies_spawn["long helmet"] = true
	elif Global.ennemies_spawn["coocker"] == false :
		Global.ennemies_spawn["coocker"] = true
	elif Global.ennemies_spawn["insect"] == false :
		Global.ennemies_spawn["insect"] = true
	elif Global.ennemies_spawn["flame"] == false :
		Global.ennemies_spawn["flame"] = true
	else :
		Global.ennemies_spawn["croc"] = true
	
	
func _on_btn_1_pressed() -> void:
	apply_effect(0)
	Global.click.emit()
	Global.close_menu_debuff.emit()



func _on_btn_2_pressed() -> void:
	apply_effect(1)
	Global.click.emit()
	Global.close_menu_debuff.emit()



func _on_btn_3_pressed() -> void:
	apply_effect(2)
	Global.click.emit()
	Global.close_menu_debuff.emit()
