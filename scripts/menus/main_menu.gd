extends Control

func _ready() -> void:
	MusicController.play_music(MusicController.music_menu)

func _on_start_pressed() -> void:
	Global.click.emit()
	get_tree().change_scene_to_file("res://scenes/menus/difficulty_menu.tscn")


func _on_options_pressed() -> void:
	Global.click.emit()
	get_tree().change_scene_to_file("res://scenes/menus/history_menu.tscn")


func _on_exit_pressed() -> void:
	Global.click.emit()
	get_tree().quit()
