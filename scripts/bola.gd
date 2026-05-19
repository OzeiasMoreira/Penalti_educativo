extends Sprite2D

var posicao_inicial = Vector2.ZERO
var destino = Vector2.ZERO
var movendo = false
var velocidade = 700
var voltando = false

func _ready():
	posicao_inicial = global_position

func chutar(pos):
	destino = pos
	movendo = true
	voltando = false

func _process(delta):
	if movendo:
		global_position = global_position.move_toward(destino, velocidade * delta)

		if global_position.distance_to(destino) < 5:
			if not voltando:
				await get_tree().create_timer(0.3).timeout
				destino = posicao_inicial
				voltando = true
			else:
				movendo = false
