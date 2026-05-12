extends Control

@onready var botao_jogar = $Jogar
@onready var botao_tutorial = $Tutorial
@onready var botao_sair = $Sair

func _ready():
	botao_jogar.pressed.connect(iniciar_jogo)
	botao_tutorial.pressed.connect(abrir_tutorial)
	botao_sair.pressed.connect(sair_do_jogo)

func iniciar_jogo():
	if has_node("/root/AudioManager"):
		get_node("/root/AudioManager").tocar_botao()
	
	# Pequeno delay para o som do botão tocar antes de trocar a cena
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

func abrir_tutorial():
	if has_node("/root/AudioManager"):
		get_node("/root/AudioManager").tocar_botao()
	get_tree().change_scene_to_file("res://scenes/Tutorial.tscn")

func sair_do_jogo():
	if has_node("/root/AudioManager"):
		get_node("/root/AudioManager").tocar_botao()
	get_tree().quit()
