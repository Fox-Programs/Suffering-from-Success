extends Area2D

var velocity = Vector2.ZERO
var damage = 1000

func _process(delta):
	position += velocity * delta
	if position.x > 1000 or position.x < -1000 or position.y > 1000 or position.y < -1000:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(damage * Global.player_attack)
		queue_free()
