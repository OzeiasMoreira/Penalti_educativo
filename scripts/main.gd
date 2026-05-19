extends Node2D

@onready var bola = $Bola
@onready var jogador = $Jogador
@onready var goleiro = $Goleiro
@onready var mensagem = $Mensagem
@onready var palavra = $Palavra
@onready var s1 = $Silabas/Silaba1
@onready var s2 = $Silabas/Silaba2
@onready var s3 = $Silabas/Silaba3
@onready var s4 = $Silabas/Silaba4
@onready var imagem_acerto = $HUD/ImagemAcerto
@onready var imagem_erro = $HUD/ImagemErro
@onready var imagem_palavra = $MolduraImagem/ImagemPalavra
@onready var pontos_label = $HUD/Placar/VBoxContainer/PontosLabel
@onready var gols_label = $HUD/Placar/VBoxContainer/GolsLabel
@onready var erros_label = $HUD/Placar/VBoxContainer/ErrosLabel
@onready var painel_premiacao = $HUD/PainelPremiacao
@onready var botao_jogar_novamente = $HUD/PainelPremiacao/Trofeu/BotaoJogarNovamente
@onready var botao_menu = $HUD/PainelPremiacao/Trofeu/BotaoMenu
@onready var trofeu_rect = $HUD/PainelPremiacao/Trofeu

var fase_atual = 0
var resposta_correta = ""
var total_gols = 0
var total_erros = 0
var chutando = false
var pontos = 0
var meta_pontos = 30
var estrelas = 3

var fases = [
	{
		"fim": "LA",
		"correta": "BO",
		"opcoes": ["BO", "CO", "PO", "MO"],
		"palavra": "BOLA",
		"imagem": preload("res://assets/bola.png")
	},
	{
		"fim": "SA",
		"correta": "CA",
		"opcoes": ["CA", "MA", "PA", "BA"],
		"palavra": "CASA",
		"imagem": preload("res://assets/casa.png")
	},
	{
		"fim": "TO",
		"correta": "PA",
		"opcoes": ["PA", "MA", "GA", "SA"],
		"palavra": "PATO",
		"imagem": preload("res://assets/pato.png")
	}
]

func _ready():
	randomize()

	if has_node("/root/AudioManager"):
		get_node("/root/AudioManager").tocar_musica(true)

	s1.pressed.connect(func(): clicar_silaba(s1))
	s2.pressed.connect(func(): clicar_silaba(s2))
	s3.pressed.connect(func(): clicar_silaba(s3))
	s4.pressed.connect(func(): clicar_silaba(s4))

	botao_jogar_novamente.pressed.connect(reiniciar_jogo)
	botao_menu.pressed.connect(voltar_ao_menu)

	carregar_fase()
	atualizar_placar()

func carregar_fase():
	var fase = fases[fase_atual]

	palavra.text = "__ " + fase["fim"]

	var opcoes_embaralhadas = fase["opcoes"].duplicate()
	opcoes_embaralhadas.shuffle()

	s1.text = opcoes_embaralhadas[0]
	s2.text = opcoes_embaralhadas[1]
	s3.text = opcoes_embaralhadas[2]
	s4.text = opcoes_embaralhadas[3]

	imagem_palavra.texture = fase["imagem"]
	resposta_correta = fase["correta"]
	mensagem.text = ""
	imagem_acerto.visible = false
	imagem_erro.visible = false
	chutando = false

	if has_node("/root/AudioManager"):
		get_node("/root/AudioManager").tocar_apito()

func _calcular_alvo_no_gol(botao) -> Vector2:
	return botao.global_position + (botao.size / 2)

func clicar_silaba(botao):
	if chutando:
		return

	chutando = true

	var alvo = _calcular_alvo_no_gol(botao)
	var texto = botao.text.strip_edges().to_upper()
	var fase = fases[fase_atual]

	jogador.animar_chute()
	bola.chutar(alvo)

	if has_node("/root/AudioManager"):
		get_node("/root/AudioManager").tocar_chute()

	if texto != resposta_correta:
		goleiro.defender(alvo)

	await get_tree().create_timer(0.8).timeout

	if texto == resposta_correta:
		mensagem.text = "GOL! FORMOU " + fase["palavra"]
		imagem_acerto.visible = true
		total_gols += 1
		pontos += 10
		atualizar_placar()

		if has_node("/root/AudioManager"):
			get_node("/root/AudioManager").tocar_gol()

		await get_tree().create_timer(1.5).timeout

		imagem_acerto.visible = false
		fase_atual += 1

		if pontos >= meta_pontos:
			mostrar_premiacao()
			return

		if fase_atual >= fases.size():
			fase_atual = 0

		carregar_fase()
	else:
		mensagem.text = "TENTE NOVAMENTE"
		imagem_erro.visible = true
		total_erros += 1
		estrelas = max(1, estrelas - 1)
		atualizar_placar()

		if has_node("/root/AudioManager"):
			get_node("/root/AudioManager").tocar_erro()

		await get_tree().create_timer(1.5).timeout

		imagem_erro.visible = false
		mensagem.text = ""
		chutando = false

func atualizar_placar():
	pontos_label.text = "PONTOS: " + str(pontos)
	gols_label.text = "GOLS: " + str(total_gols)
	erros_label.text = "ERROS: " + str(total_erros)

func mostrar_premiacao():
	chutando = true
	
	var textura_estrelas
	if estrelas == 3:
		textura_estrelas = load("res://assets/3estrelas.png")
	elif estrelas == 2:
		textura_estrelas = load("res://assets/2estrelas.png")
	else:
		textura_estrelas = load("res://assets/1estrelas.png")
		
	trofeu_rect.texture = textura_estrelas
	painel_premiacao.visible = true
	if has_node("/root/AudioManager"):
		get_node("/root/AudioManager").tocar_vitoria()

func reiniciar_jogo():
	if has_node("/root/AudioManager"):
		get_node("/root/AudioManager").tocar_botao()
	pontos = 0
	total_gols = 0
	total_erros = 0
	estrelas = 3
	fase_atual = 0
	painel_premiacao.visible = false
	carregar_fase()
	atualizar_placar()

func voltar_ao_menu():
	if has_node("/root/AudioManager"):
		get_node("/root/AudioManager").tocar_botao()
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")
