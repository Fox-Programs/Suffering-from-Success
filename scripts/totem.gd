extends Node2D

var player_in_range = false
signal open_menu_debuff
@export var menu_debuff_scene : PackedScene

func _process(_delta):
	# On vérifie si le joueur est proche ET s'il appuie sur E
	if player_in_range and Input.is_action_just_pressed("interact"):
		open_interact_menu()

func _on_body_entered(body):
	# On vérifie que c'est bien le joueur (ex: s'il est dans le groupe "player")
	if body.is_in_group("player"):
		player_in_range = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false

func open_interact_menu():
	get_tree().paused = true
	Global.stop_timer()
	Global.open_menu_debuff.emit()
	var menu = menu_debuff_scene.instantiate()
	get_tree().root.add_child(menu)
	menu.pick_random_effects()
	Global.create_totem.emit()
	queue_free()
