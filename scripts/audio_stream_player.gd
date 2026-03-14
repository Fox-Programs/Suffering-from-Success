extends AudioStreamPlayer

@onready var music_menu = $music_menu_file
@onready var music_game = $music_game_file
@onready var sound_click = $sound_click_file
@onready var sound_tap = $sound_tap_file

func _ready():
	Global.open_menu_debuff.connect(db_level_down)
	Global.close_menu_debuff.connect(db_level_up)
	Global.click.connect(click_sound)
	Global.tap.connect(tap_sound)
	
func play_music(music_node):
	# On vérifie si c'est déjà cette musique qui joue
	if stream == music_node.stream:
		return
		
	# On règle le volume selon le nœud choisi
	if music_node == music_menu:
		volume_db = 0
	else:
		volume_db = -10
		
	stream = music_node.stream
	play()
		
func db_level_down():
	volume_db -= 5
	
func db_level_up():
	volume_db += 5
	
func click_sound():
	play_sfx(sound_click.stream)

func tap_sound():
	play_sfx(sound_tap.stream)

# Fonction utilitaire pour éviter de répéter le code des SFX
func play_sfx(sfx_stream):
	if (randf()*100 > Global.nb_enemie * 2):
		if sfx_stream == null: return
		var player = AudioStreamPlayer.new()
		add_child(player)
		player.stream = sfx_stream
		player.bus = "SFX"
		player.play()
		player.finished.connect(player.queue_free)

func _on_finished() -> void:
	play()
