extends Node
class_name RegrasDoMundo

#---- Variaveis ----#
var Gravidade = 1200
var Vida_player = 100
var Chakra_player = 40

var personagem = 1


func _process(delta):
	if(Vida_player > 100):
		Vida_player = 100
	if(Chakra_player > 40):
		Chakra_player = 40
	
