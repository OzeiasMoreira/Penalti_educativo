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
@onready var imagem_acerto = $ImagemAcerto
@onready var imagem_erro = $ImagemErro
@onready var imagem_palavra = $MolduraImagem/ImagemPalavra
@onready var gols_label = $HUD/Placar/VBoxContainer/GolsLabel
@onready var erros_label = $HUD/Placar/VBoxContainer/ErrosLabel

var fase_atual = 0
var resposta_correta = ""
var total_gols = 0
var total_erros = 0

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
	
	# Trocar para a música de jogo
	if has_node("/root/AudioManager"):
		get_node("/root/AudioManager").tocar_musica(true)
		
	s1.pressed.connect(func(): clicar_silaba(s1))
	s2.pressed.connect(func(): clicar_silaba(s2))
	s3.pressed.connect(func(): clicar_silaba(s3))
	s4.pressed.connect(func(): clicar_silaba(s4))
	carregar_fase()

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
	
	# Apito para começar a rodada
	if has_node("/root/AudioManager"):
		get_node("/root/AudioManager").tocar_apito()

func _calcular_alvo_no_gol(botao) -> Vector2:
	# Define a área do gol baseada nas posições do campo
	# O gol fica na parte superior central do campo, ao redor do goleiro
	var gol_centro_x = goleiro.position.x   # Centro horizontal do gol (596)
	var gol_topo_y = goleiro.position.y - 55  # Topo do gol (acima do goleiro)
	var gol_base_y = goleiro.position.y + 55  # Base do gol (abaixo do goleiro)
	var gol_largura = 350  # Largura total do gol
	
	# Mapear cada botão para uma posição dentro do gol
	# Cada sílaba vai para um canto diferente, com boa separação
	if botao == s1:
		# Silaba1 (esquerda cima) -> canto superior esquerdo do gol
		return Vector2(gol_centro_x - gol_largura * 0.45, gol_topo_y)
	elif botao == s2:
		# Silaba2 (esquerda baixo) -> canto inferior esquerdo do gol
		return Vector2(gol_centro_x - gol_largura * 0.45, gol_base_y)
	elif botao == s3:
		# Silaba3 (direita cima) -> canto superior direito do gol
		return Vector2(gol_centro_x + gol_largura * 0.45, gol_topo_y)
	elif botao == s4:
		# Silaba4 (direita baixo) -> canto inferior direito do gol
		return Vector2(gol_centro_x + gol_largura * 0.45, gol_base_y)
	
	# Fallback: centro do gol
	return Vector2(gol_centro_x, goleiro.position.y)

func clicar_silaba(botao):
	var alvo = _calcular_alvo_no_gol(botao)
	jogador.animar_chute()
	bola.chutar(alvo)
	
	# Som de chute
	if has_node("/root/AudioManager"):
		get_node("/root/AudioManager").tocar_chute()

	var texto = botao.text.strip_edges().to_upper()
	var fase = fases[fase_atual]

	if texto != resposta_correta:
		goleiro.defender(alvo)

	# Espera o tempo da animação da bola chegar ao alvo
	await get_tree().create_timer(0.7).timeout

	if texto == resposta_correta:
		mensagem.text = "GOL! FORMOU " + fase["palavra"]
		imagem_acerto.visible = true
		
		total_gols += 1
		atualizar_placar()
		
		# Som de gol
		if has_node("/root/AudioManager"):
			get_node("/root/AudioManager").tocar_gol()
		await get_tree().create_timer(1.5).timeout
		imagem_acerto.visible = false

		fase_atual += 1

		if fase_atual >= fases.size():
			fase_atual = 0

		carregar_fase()
	else:
		mensagem.text = "TENTE NOVAMENTE"
		imagem_erro.visible = true
		
		total_erros += 1
		atualizar_placar()
		
		# Som de erro
		if has_node("/root/AudioManager"):
			get_node("/root/AudioManager").tocar_erro()

		await get_tree().create_timer(1.5).timeout
		imagem_erro.visible = false
		mensagem.text = ""

func atualizar_placar():
	gols_label.text = "GOLS: " + str(total_gols)
	erros_label.text = "ERROS: " + str(total_erros)
