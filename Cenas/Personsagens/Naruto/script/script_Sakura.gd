extends PersonagemGenerico


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
#	____--- EM RELAÇÃO A QUAL PERSONAGEM FOI ESCOLHIDO ---____
	$img_sakura.visible = false
	
	if (Global.personagem == 2):
		$img_sakura.visible = true
	if (Global.personagem != 2):
		$".".queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
