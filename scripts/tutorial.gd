extends Node2D

@onready var label_instrucao = $Instrucoes/VBoxContainer/Label
@onready var exemplo_imagem = $Instrucoes/VBoxContainer/ExemploImagem
@onready var botao_proximo = $Proximo
@onready var botao_voltar = $Voltar

var passo_atual = 0
var imagens = [
	preload("res://assets/bola-removebg-preview.png"),
	preload("res://assets/alvoozi.png"),
	preload("res://assets/jogador.png"),
	preload("res://assets/goleiro.png")
]
var instrucoes = [
	"Bem-vindo ao Pênalti Educativo!\nOlhe para a imagem para saber qual é a palavra.",
	"Complete a palavra encontrando a PRIMEIRA sílaba que falta.",
	"Clique na sílaba correta para chutar a bola e fazer o GOL!",
	"Se o goleiro defender, tente outra sílaba!\nBom jogo!"
]

func _ready():
	passo_atual = 0
	atualizar_tutorial()
	
	botao_proximo.pressed.connect(proximo_passo)
	botao_voltar.pressed.connect(voltar_ao_menu)

func atualizar_tutorial():
	label_instrucao.text = instrucoes[passo_atual]
	exemplo_imagem.texture = imagens[passo_atual]
	
	if passo_atual == instrucoes.size() - 1:
		botao_proximo.text = "ENTENDI!"
	else:
		botao_proximo.text = "PRÓXIMO"

func proximo_passo():
	if has_node("/root/AudioManager"):
		get_node("/root/AudioManager").tocar_botao()
		
	passo_atual += 1
	if passo_atual < instrucoes.size():
		atualizar_tutorial()
	else:
		voltar_ao_menu()

func voltar_ao_menu():
	if has_node("/root/AudioManager"):
		get_node("/root/AudioManager").tocar_botao()
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")
