extends CharacterBody2D


const SPEED = 150.0
var MAX_LIFE = Global.max_player_life

@onready var animated_sprite = $AnimatedSprite2D
@onready var shoot_timer = $"../TimerWeaponPlayer"
@onready var sound_explosion = $"../Explosion/SoundExplosion"

@export var projectile_scene: PackedScene

func _process(delta: float) -> void:
	Global.player_life += Global.regeneration
	if Global.player_life > MAX_LIFE:
		Global.player_life = MAX_LIFE

func _physics_process(delta: float) -> void:

	# Get the input direction
	var direction_x := Input.get_axis("move_left", "move_right")
	var direction_y := Input.get_axis("move_up", "move_down")
	
	# Flip the sprite
	if direction_x > 0:
		animated_sprite.flip_h = false
	elif direction_x < 0:
		animated_sprite.flip_h = true
	
	# Apply movements
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	# Play animations
	if direction_x == 0 and direction_y == 0:
		animated_sprite.play("idle")
	else :
		animated_sprite.play("run")

	move_and_slide()
	

func _on_timer_weapon_player_timeout() -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	if Global.probability_attack_player > randf():
		if enemies.size() > 0:
			# Trouver l'ennemi le plus proche
			var closest_enemy = enemies[0]
			for enemy in enemies:
				if position.distance_to(enemy.position) < position.distance_to(closest_enemy.position):
					closest_enemy = enemy
			
			# Tirer
			shoot(closest_enemy.position)
			
func _on_explosion_timeout() -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies :
		enemy.take_damage(100000)
	sound_explosion.play()
	Global.explosion.emit()
			
func shoot(target_position):
	var p = projectile_scene.instantiate()
	p.position = global_position
	p.velocity = (target_position - global_position).normalized() * 400
	get_tree().current_scene.add_child(p)
	
func take_damage(amount):
	Global.tap.emit()
	Global.player_life -= amount
	Global.player_life = int(round(Global.player_life))
	if Global.player_life <= 0:
		$CollisionShape2D.set_deferred("disabled", true)
		die()
		
func die():
	get_tree().change_scene_to_file("res://scenes/menus/end_menu.tscn")
	
