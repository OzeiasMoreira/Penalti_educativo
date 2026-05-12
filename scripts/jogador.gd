extends Sprite2D

var posicao_original

func _ready():
	posicao_original = position

func animar_chute():
	var tween = get_tree().create_tween()
	
	# Puxa o corpo para trás
	tween.tween_property(self, "rotation_degrees", -10.0, 0.1)
	
	# Joga o corpo para frente simulando o chute
	tween.tween_property(self, "rotation_degrees", 20.0, 0.1)
	tween.parallel().tween_property(self, "position:y", posicao_original.y - 15, 0.1)
	
	# Retorna à posição e rotação originais
	tween.tween_property(self, "rotation_degrees", 0.0, 0.2)
	tween.parallel().tween_property(self, "position:y", posicao_original.y, 0.2)
