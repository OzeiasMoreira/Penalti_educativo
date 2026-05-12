extends Sprite2D

var destino = Vector2()
var movendo = false
var velocidade = 850
var posicao_inicial

func _ready():
	posicao_inicial = position

func defender(pos):
	# Goleiro se move apenas horizontalmente para defender
	destino = Vector2(pos.x, posicao_inicial.y)
	movendo = true

func _process(delta):
	if movendo:
		position = position.move_toward(destino, velocidade * delta)

		if position.distance_to(destino) < 5:
			movendo = false
			await get_tree().create_timer(0.3).timeout
			destino = posicao_inicial
			movendo = true
