extends Area2D

var velocity = Vector2.ZERO
var damage = Global.enemie_attack * 1.4

func _process(delta):
	position += velocity * delta
	if position.x > 700 or position.x < -700 or position.y > 700 or position.y < -700:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(damage)
		queue_free()
