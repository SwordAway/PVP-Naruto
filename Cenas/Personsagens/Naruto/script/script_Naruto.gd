extends PersonagemGenerico

var run = false
var ataque = false
var ataque_clone = preload("res://Cenas/Personagens/Naruto/Ataque_clone.tscn")
var shuriken = preload("res://Cenas/Ataques_e_habilidades/Shuriken.tscn")
var qtd_socos = 0
var combos = false
var dano = false



func _ready():
#	____--- EM RELAÇÃO A QUAL PERSONAGEM FOI ESCOLHIDO ---____
	$img_naruto.visible = false
	
	if (Global.personagem == 1):
		$img_naruto.visible = true
	if (Global.personagem != 1):
		$".".queue_free()
		
	self.Velocidade_de_movimento = 200 
	run = false
	ataque = false
	combos = false
#_______________Exibir personagem para testes___________

	

#_______________Reviver temporario para testes___________
func _reviver():
	
	if($".".global_position.y > 266):
		get_tree().change_scene("res://Cenas/Cenario/Cenario.tscn")
		
	pass
#________________________________________________________

func _damage():
	$Anima.play("sofrer_dano")
	self.Velocidade_de_movimento = 0
	dano = true
	pass
	
func _caindo():
	$Anima.play("levantar")
	self.Velocidade_de_movimento = 0
	dano = true
	pass

func _animacoes_basicas(delta):
	
	if (not ataque):
	#	-----Controle de correr, andar e parar-----
		if(Input.is_action_pressed("correr")):
			run = true
		else: 
			run = false
			
		if is_on_floor() && self.Movimento.x:
			if(run):
				self.Velocidade_de_movimento = 300 
				$Anima.play("correndo")
			else:
				self.Velocidade_de_movimento = 200 
				$Anima.play("andando")
				
		elif not $Anima.current_animation == "pulando" && is_on_floor() or $Anima.current_animation == "sofrer_dano" or $Anima.current_animation == "levantar":
			$Anima.play("parado")
			
	#	-----Controle de cair e pular-----
		if is_on_floor() && Input.is_action_just_pressed("ui_up"):
			$Anima.play("pulando")
			
		elif not is_on_floor() && not $Anima.current_animation == "pulando" and not $Anima.current_animation == "parado" :
			$Anima.play("caindo")
			
#			-----Jutsu clone-----
		if Input.is_action_just_pressed("jutsu_clone"):
			$fum.visible = true
			$Anima.play("jutsu_clone")
			$fumaca.play("fumaca")
			self.Velocidade_de_movimento = 0
			ataque = true
			
			var clone = ataque_clone.instance()
			clone.global_position = $Shuriken_eClone.global_position
			clone.z_index = -1
			if(self.Controle_do_giro == false):
				clone.scale.x = -1
			get_tree().root.add_child(clone)
			
		elif Input.is_action_just_pressed("shuriken"):
			$Anima.play("atk_shuriken")
			self.Velocidade_de_movimento = 0
			ataque = true
			
			var atk_shuriken = shuriken.instance()
			atk_shuriken.global_position = $Shuriken_eClone.global_position
			atk_shuriken.z_index = -1
			if(self.Controle_do_giro == false):
				atk_shuriken.scale.x = -1
			get_tree().root.add_child(atk_shuriken)
			
#			-----Quebra defesa-----
		elif Input.is_action_just_pressed("quebra_defesa"):
			$Anima.play("quebra_defesa")
			$Quebra_defesa/Quebra_def/Collision_quebra_def.disabled = false
			ataque = true
			
#			-----Inicio dos combos-----
		elif Input.is_action_just_pressed("combo") and is_on_floor():
			self.Velocidade_de_movimento = 0
			$Anima.play("soco")
			$Quebra_defesa/Socos/Collision_socos.disabled = false
			ataque = true
			
	
	elif(ataque):
		
		if Input.is_action_just_pressed("combo") and is_on_floor():
				self.Velocidade_de_movimento = 0
				$Anima.play("cabecada")
				$Quebra_defesa/Socos/Collision_socos.disabled = false
				combos = true
				
#		if(combos):
#	#		Sistemas de combos
#			if Input.is_action_just_pressed("combo") and is_on_floor() and not $Anima.current_animation == "cabecada":
#				self.Velocidade_de_movimento = 0
#				$Anima.play("socao")
				
	if(dano):
		
		pass


	
func _physics_process(delta):
	
	_reviver()
	_animacoes_basicas(delta)
	pass
	

func _on_Anima_animation_finished(anim_name):
	
# Controlando a animação de cair após o pulo
	if(anim_name == "pulando" && not is_on_floor()):
		$Anima.play("caindo")
		
# Controlando a animação de atacar
	if (anim_name == "jutsu_clone" or anim_name == "fumaca" or anim_name == "quebra_defesa"
	or anim_name == "soco" or anim_name == "cabecada" or anim_name == "atk_shuriken"):
		$Quebra_defesa/Quebra_def/Collision_quebra_def.disabled = true
		$Quebra_defesa/Socos/Collision_socos.disabled = true
		$fum.visible = false
		self.Velocidade_de_movimento = 200
		ataque = false
		
	if (anim_name == "sofrer_dano" or anim_name == "levantar"):
		$Quebra_defesa/Quebra_def/Collision_quebra_def.disabled = true
		$Quebra_defesa/Socos/Collision_socos.disabled = true
		$Anima.play("parado")
		self.Velocidade_de_movimento = 200
		dano = false
#	if(anim_name == "socao"):
#		$fum.visible = false
#		self.Velocidade_de_movimento = 200
#		ataque = false
#		combos = false
		
# Controlando o combo
#	if(anim_name == "soco" or anim_name == "cabecada" ):
#		self.Velocidade_de_movimento = 200
#		qtd_socos = 0
#		ataque = false
		
#	if (anim_name == "socao"):
#		ataque = false
#		socos = false
		pass

# ADICIONAR CADA ATAQUE (NOME) DOS OUTROS PERSONAGENS
func _on_Recebe_dano_area_entered(area):
	
#	
	if (area.name == "Shuriken" or area.name == "Socos") or area.name == "Clone":
		_damage()
		pass
	if (area.name == "Quebra_def"):
		_caindo()
		pass
	
	
	pass # Replace with function body.


