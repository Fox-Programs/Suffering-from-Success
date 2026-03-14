extends Node2D

const SPEED = 160

var direction_x = 1
var direction_y = 1
var player = null

var health = Global.enemie_life * 3.5
var damage = Global.enemie_attack * 1.5

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D

func _process(delta: float) -> void:
	# On vérifie si on a bien un joueur avant de bouger
	if player == null:
		return 

	# --- Logique Axe X ---
	if position.x > player.position.x:
		direction_x = -1
		animated_sprite.flip_h = true
		position.x += SPEED * delta * direction_x
	elif position.x < player.position.x:
		direction_x = 1
		animated_sprite.flip_h = false
		position.x += SPEED * delta * direction_x
	
	
	# --- Logique Axe Y ---
	if position.y > player.position.y:
		direction_y = -1
		position.y += SPEED * delta * direction_y
	elif position.y < player.position.y:
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

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(damage)
