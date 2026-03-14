extends Node

var score = 0

@onready var player = $"../Player"

@export var totem_scene: PackedScene
@export var ninja_scene: PackedScene
@export var boat_scene: PackedScene
@export var knight_scene: PackedScene
@export var long_helmet_scene: PackedScene
@export var coocker_scene: PackedScene
@export var insect_scene: PackedScene
@export var flame_scene: PackedScene
@export var croc_scene: PackedScene

func _ready():
	MusicController.play_music(MusicController.music_game)
	Global.reset_timer()
	Global.start_timer()
	Global.create_totem.connect(spawn_totem)
	print(Global.ennemies_spawn)
	for i in range (3) :
		spawn_totem()
		
func spawn_totem():
	var totem = totem_scene.instantiate()
	# Définir des limites selon la taille de ta map
	totem.position = Vector2(randf_range(-600, 600), randf_range(-600, 600))
	add_child(totem)
	
func nb_true_in_enemies_dict() -> int:
	var compteur = 0
	var dict = Global.ennemies_spawn
	for valeur in dict.values():
		if valeur == true:
			compteur += 1
	return compteur

func _on_timer_spawn_timeout() -> void:
	for i in range (Global.nb_enemie):
		var rand = randi() % nb_true_in_enemies_dict()
		if rand == 0 :
			var new_ninja = ninja_scene.instantiate()
			new_ninja.player = player 
			var random_offset = Vector2(randf_range(-600, 600), randf_range(-600, 600))
			new_ninja.position = random_offset
			get_tree().current_scene.add_child(new_ninja)
		if rand == 1 :
			var new_boat = boat_scene.instantiate()
			new_boat.player = player 
			var random_offset = Vector2(randf_range(-600, 600), randf_range(-600, 600))
			new_boat.position = random_offset
			get_tree().current_scene.add_child(new_boat)
		if rand == 2 :
			var new_knight = knight_scene.instantiate()
			new_knight.player = player 
			var random_offset = Vector2(randf_range(-600, 600), randf_range(-600, 600))
			new_knight.position = random_offset
			get_tree().current_scene.add_child(new_knight)
		if rand == 3 :
			var new_long_helmet = long_helmet_scene.instantiate()
			new_long_helmet.player = player 
			var random_offset = Vector2(randf_range(-600, 600), randf_range(-600, 600))
			new_long_helmet.position = random_offset
			get_tree().current_scene.add_child(new_long_helmet)
		if rand == 4 :
			var new_coocker = coocker_scene.instantiate()
			new_coocker.player = player 
			var random_offset = Vector2(randf_range(-600, 600), randf_range(-600, 600))
			new_coocker.position = random_offset
			get_tree().current_scene.add_child(new_coocker)
		if rand == 5 :
			var new_insect = insect_scene.instantiate()
			new_insect.player = player 
			var random_offset = Vector2(randf_range(-600, 600), randf_range(-600, 600))
			new_insect.position = random_offset
			get_tree().current_scene.add_child(new_insect)
		if rand == 6 :
			var new_flame = flame_scene.instantiate()
			new_flame.player = player 
			var random_offset = Vector2(randf_range(-600, 600), randf_range(-600, 600))
			new_flame.position = random_offset
			get_tree().current_scene.add_child(new_flame)
		if rand == 7 :
			var new_croc = croc_scene.instantiate()
			new_croc.player = player 
			var random_offset = Vector2(randf_range(-600, 600), randf_range(-600, 600))
			new_croc.position = random_offset
			get_tree().current_scene.add_child(new_croc)


func _on_timer_weapon_ninja_timeout() -> void:
	var all_ennemies = get_tree().get_nodes_in_group("enemies")
	for ennemies in all_ennemies :
		if Global.probability_attack_enemie > randf():
			if not ennemies.is_in_group("dont_shoot"):
				ennemies.shoot_at_player()
		
