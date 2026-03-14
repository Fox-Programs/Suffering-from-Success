extends Control

func _on_easy_pressed() -> void:
	Global.easy()
	Global.click.emit()
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_medium_pressed() -> void:
	Global.medium()
	Global.click.emit()
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_hard_pressed() -> void:
	Global.hard()
	Global.click.emit()
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_extreme_pressed() -> void:
	Global.extreme()
	Global.click.emit()
	get_tree().change_scene_to_file("res://scenes/game.tscn")
