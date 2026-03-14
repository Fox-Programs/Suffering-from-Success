extends CanvasLayer

var time_spend = 0

var coeff_difficulty = 1

@onready var label_state = $VBoxContainer/State
@onready var label_description = $VBoxContainer/Description
@onready var label_time_life = $VBoxContainer/TimeLife

func _ready() -> void:
	MusicController.play_music(MusicController.music_menu)
	Global.stop_timer()
	time_spend = Global.game_time
	@warning_ignore("integer_division")
	label_time_life.text = "Temps de vie en jeu : " + str(int(time_spend)/60) + "m" + str(int(time_spend)%60) + "s"
	success_state()

func success_state():
	choose_coeff()
	if time_spend < 30 * coeff_difficulty:
		label_state.text = choose_state(1)
		label_description.text = choose_description(1)
	elif time_spend < 60 * coeff_difficulty:
		label_state.text = choose_state(2)
		label_description.text = choose_description(2)
	elif time_spend < 90 * coeff_difficulty:
		label_state.text = choose_state(3)
		label_description.text = choose_description(3)
	elif time_spend < 120 * coeff_difficulty:
		label_state.text = choose_state(4)
		label_description.text = choose_description(4)
	elif time_spend < 150 * coeff_difficulty:
		label_state.text = choose_state(5)
		label_description.text = choose_description(5)
	else:
		label_state.text = choose_state(6)
		label_description.text = choose_description(6)
		
		
func choose_state(state) -> String:
	var result = ""
	if state == 1:
		result = "l'Espoir des Damnés"
	elif state == 2:
		result = "le Porteur d'Ombre"
	elif state == 3:
		result = "l'Outil du Destin"
	elif state == 4:
		result = "le Calvaire Ambulant"
	elif state == 5:
		result = "le Fléau des Vivants"
	else:
		result = "L'Annihilateur"
	return ("On vous voit comme " + result)
		
func choose_description(state) -> String:
	if state == 1:
		return "Ils voient encore en vous le remède. Chaque vie sauvée renforce leur foi, et ils prient pour que votre fardeau s'allège."
	elif state == 2:
		return "Le doute s'installe. On s'écarte sur votre passage, car là où vous restez trop longtemps, les fleurs fanent et les visages pâlissent."
	elif state == 3:
		return "On pense que pour vous la mort est devenue un outil. Vous ne cherchez plus à épargner, vous avancez, laissant le poison de votre âme s'occuper des faibles."
	elif state == 4:
		return "Les mères cachent leurs enfants quand vous approchez. Vous n'êtes plus un homme pour eux, mais la manifestation physique de leur agonie."
	elif state == 5:
		return "Les villages que vous traversez deviennent des cimetières à ciel ouvert. Le peuple a cessé de prier pour votre salut, ils prient pour votre fin."
	else:
		return "Le silence est votre seul compagnon. Il ne reste personne pour vous juger ou vous craindre. Vous êtes la fin de toute chose, le dernier souffle d'un monde mourant."
		
	
func choose_coeff():
	match Global.difficulty:
		"easy": coeff_difficulty = 0.75
		"medium": coeff_difficulty = 2
		"hard": coeff_difficulty = 4
		"extreme": coeff_difficulty = 7

func _on_replay_pressed() -> void:
	Global.click.emit()
	Global.reset.emit()
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")



func _on_quit_pressed() -> void:
	Global.click.emit()
	get_tree().quit()
