extends Node

@onready var sfx_chute = $SFXChute
@onready var sfx_gol = $SFXGol
@onready var sfx_erro = $SFXErro
@onready var sfx_errou_vocal = $SFXErrouVocal
@onready var sfx_apito = $SFXApito
@onready var sfx_botao = $SFXBotao
@onready var music_player = $MusicPlayer
@onready var botao_volume = $CanvasLayer/Control/Tab/BotaoSom
@onready var botao_sair = $CanvasLayer/Control/Tab/BotaoSair
@onready var slider_volume = $CanvasLayer/Control/SliderVolume
@onready var sfx_tafarel = $SFXTafarel
@onready var sfx_luva = $SFXLuva
@onready var music_uefa = $MusicUEFA

var mutado = false

# Texturas
var tex_volume = preload("res://assets/menu/volume.png")
var tex_mudo = preload("res://assets/menu/muted.png")

func _ready():
	# Começar a música se houver uma configurada
	tocar_musica()
	# Tocar apito inicial
	tocar_apito()
	
	# Conectar botões e slider
	botao_volume.pressed.connect(alternar_mudo)
	botao_sair.pressed.connect(voltar_ao_menu)
	slider_volume.value_changed.connect(ajustar_volume)
	
	# Inicializar volume
	ajustar_volume(slider_volume.value)
	atualizar_icone()

func ajustar_volume(valor):
	var db = linear_to_db(valor / 100.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), db)
	# Se o volume for 0, silenciar
	if valor == 0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), mutado)

func voltar_ao_menu():
	tocar_botao()
	if music_uefa.playing:
		music_uefa.stop()
	tocar_musica()
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")

func tocar_apito():
	if sfx_apito.stream:
		sfx_apito.play()

func tocar_chute():
	if sfx_chute.stream:
		sfx_chute.play()

func tocar_gol():
	var sorteio = randi() % 2
	if sorteio == 0:
		if sfx_gol.stream:
			sfx_gol.play()
	else:
		if sfx_luva.stream:
			sfx_luva.play()
			await get_tree().create_timer(3.0).timeout
			sfx_luva.stop()

func tocar_erro():
	var sorteio = randi() % 2
	if sfx_erro.stream:
		sfx_erro.play()
		
	if sorteio == 0:
		if sfx_errou_vocal.stream:
			sfx_errou_vocal.play()
	else:
		if sfx_tafarel.stream:
			sfx_tafarel.play()
			await get_tree().create_timer(3.0).timeout
			sfx_tafarel.stop()

func tocar_botao():
	if sfx_botao.stream:
		sfx_botao.play()

func tocar_vitoria():
	parar_musica()
	if $MusicPlayer2.playing:
		$MusicPlayer2.stop()
		
	if music_uefa.stream:
		music_uefa.play()
		await get_tree().create_timer(7.0).timeout
		music_uefa.stop()

func tocar_musica(fundo_alternativo = false):
	if fundo_alternativo and $MusicPlayer2.stream:
		music_player.stop()
		$MusicPlayer2.play()
	elif music_player.stream and not music_player.playing:
		$MusicPlayer2.stop()
		music_player.play()

func parar_musica():
	music_player.stop()

func alternar_mudo():
	mutado = !mutado
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), mutado)
	atualizar_icone()
	return mutado

func atualizar_icone():
	if mutado:
		botao_volume.texture_normal = tex_mudo
	else:
		botao_volume.texture_normal = tex_volume
