extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.explosion.connect(upscale)


func upscale():
	self.show()
	self.scale = Vector2(0.1, 0.1)
	var new_scale = Vector2(50, 50)
	var tween = create_tween()
	tween.tween_property(self, "scale", new_scale, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(self.hide)
