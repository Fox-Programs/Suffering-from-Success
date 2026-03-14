extends Area2D

var velocity = Vector2.ZERO
var damage = 100

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(damage * Global.player_attack)
		
