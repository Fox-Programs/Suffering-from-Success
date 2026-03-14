extends Node2D

const SPEED = 120

var direction_x = 1
var direction_y = 1
var player = null

var health = Global.enemie_life * 2.5

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@export var weapon_long_helmet: PackedScene

func _process(delta: float) -> void:
	# On vérifie si on a bien un joueur avant de bouger
	if player == null:
		return 

	# --- Logique Axe X ---
	if position.x > player.position.x + 70:
		direction_x = -1
		animated_sprite.flip_h = true
		position.x += SPEED * delta * direction_x
	elif position.x < player.position.x - 70:
		direction_x = 1
		animated_sprite.flip_h = false
		position.x += SPEED * delta * direction_x
	
	
	# --- Logique Axe Y ---
	if position.y > player.position.y + 70:
		direction_y = -1
		position.y += SPEED * delta * direction_y
	elif position.y < player.position.y - 70:
		direction_y = 1
		position.y += SPEED * delta * direction_y
		
func take_damage(amount):
	health -= amount
	if health <= 0:
		remove_from_group("enemies")
		set_physics_process(false)
		collision.set_deferred("disabled", true)
		animated_sprite.play("die")
		await animated_sprite.animation_finished
		queue_free()



func shoot_at_player():
	if player == null or weapon_long_helmet == null:
		return
		
	var projectile = weapon_long_helmet.instantiate()
	# 1. Position de départ : sur le ninja
	projectile.position = global_position 
	# 2. Calcul de la direction : (Cible - Source) normalisé
	var direction = (player.global_position - global_position).normalized()
	# 3. On donne la vitesse et la direction au projectile
	projectile.velocity = direction * 300 
	# 4. On ajoute l'arme à la scène principale
	get_tree().current_scene.add_child(projectile)
