extends Area2D
	
export var movespeed = 150

onready var main = get_parent()

var input1 = "ui_s"
var input2 = "ui_w"
var first = true
var viewport_height = 600
var viewport_width = 1024
var start_game = true

func _ready():
	main.connect('created_ball', self, '_on_main_created_ball')

func _on_main_created_ball():
	var Ball = get_node('../Ball')
	print(Ball)
	if first == true:
		Ball.connect('game_over', self, '_on_Ball_game_over')
		first = false

func _process(delta):
	if start_game != true:
		var up_down = movedir(input1, input2)
		if up_down.y < 0:
			if position.y-($Sprite.texture.get_size().y/2) > 0:
				position += up_down * movespeed * delta
		elif up_down.y > 0:
			if position.y+($Sprite.texture.get_size().y/2) < viewport_height:
				position += up_down * movespeed * delta
		#if name == name_arr[1]:
			#print(start_game)
			#print('Player 2 ' + str(position))
			#var up_down = movedir("ui_down", "ui_up")
			#print(up_down)
			#if up_down.y < 0:
				#if position.y-($Sprite.texture.get_size().y/2) > 0:
				#	position += up_down * movespeed * delta
			#elif up_down.y > 0:
				#if position.y+($Sprite.texture.get_size().y/2) < viewport_height:
					#position += up_down * movespeed * delta
	
func movedir(input1, input2):
	var movedir = Vector2(0, 0)
	if Input.is_action_pressed(input1):
		movedir.y += 1
	if Input.is_action_pressed(input2):
		movedir.y -= 1
	return movedir

func _on_Ball_game_over():
	position.y = 296
	start_game = true
	
func _on_HUD_start_game():
	start_game = false

