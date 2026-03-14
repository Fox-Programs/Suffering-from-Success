extends Control

func _on_return_btn_pressed() -> void:
	Global.click.emit()
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
