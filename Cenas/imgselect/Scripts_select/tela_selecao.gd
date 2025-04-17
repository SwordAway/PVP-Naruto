extends Node2D


func _ready():
	pass
	
func _process(delta):
	$naruto.modulate = Color(0.2, 0.2, 0.2)
	$sasuke.modulate = Color(0.2, 0.2, 0.2)
	$sakura.modulate = Color(0.2, 0.2, 0.2)
	
	
	if (Input.is_action_just_pressed("ui_left")):
		if (Global.personagem == 1):
			Global.personagem = 3
		else:
			Global.personagem -= 1
	if (Input.is_action_just_pressed("ui_right")):
		if (Global.personagem == 3):
			Global.personagem = 1
		else:
			Global.personagem += 1
	elif(Input.is_action_just_pressed("enter")):
		get_tree().change_scene("res://Cenas/Cenario/Cenario.tscn")
		
	if (Global.personagem == 1):
		$naruto.modulate = Color(1, 1, 1)
	elif (Global.personagem == 2):
		$sasuke.modulate = Color(1, 1, 1)
	elif (Global.personagem == 3):
		$sakura.modulate = Color(1, 1, 1)
