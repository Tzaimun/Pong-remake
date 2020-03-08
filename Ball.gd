extends RigidBody2D

signal game_over

onready var player1 = get_node('../Player1')
onready var player2 = get_node('../Player2')
onready var HUD = get_node('../HUD')

export var vertical_vel = 500
export var horizontal_vel = 500

var move_dir = Vector2(horizontal_vel, 0)
var collision_angle = 0
var viewport_height = 600
var viewport_width = 1024
var body_entered = false
var new_game = true

func _ready():
	linear_velocity.x = horizontal_vel
	player1.connect('body_entered', self, '_on_Player1_body_entered')
	player2.connect('body_entered', self, '_on_Player2_body_entered')
	HUD.connect('start_game' , self, '_on_HUD_start_game')
	
func _physics_process(_delta):
	if position.y > viewport_height || position.y < 0:
		linear_velocity.y = -linear_velocity.y
	if position.x < 0 || position.x > viewport_width:
		emit_signal('game_over')
		new_game = true
		queue_free()
	if body_entered:
		linear_velocity = Vector2(horizontal_vel * move_dir.x, vertical_vel * move_dir.y)
		#print(linear_velocity)
		body_entered = false

func on_body_entered(_body, player):
	var player_size = player.get_node('Sprite').texture.get_size()
	var player_pos = Vector2(int(round(player.position.x)), int(round(player.position.y)))
	var ball_pos = Vector2(int(round(position.x)), int(round(position.y)))
	var collision_point = (player_pos.y - ball_pos.y)/(player_size.y*0.5)
	collision_angle = collision_point*90
	move_dir = Vector2(abs(horizontal_vel), vertical_vel * collision_angle/100).normalized()
	if move_dir.y < 0.05 && move_dir.y > -0.05:
		if new_game == false:
			move_dir = Vector2(abs(horizontal_vel), vertical_vel * 0.45).normalized()
	horizontal_vel = -horizontal_vel
	body_entered = true
	print('move_dir ' + str(move_dir) + ' collision_point and collision_angle ' + str(collision_point)
		 + ' ' + str(collision_angle))
	#print(new_game)

func _on_Player1_body_entered(body):
	on_body_entered(body, player1)
	
func _on_Player2_body_entered(body):
	on_body_entered(body, player2)

func winningplayer():
	var pos = Vector2(int(round(position.x)), int(round(position.y)))
	var winning_player = 1
	if pos.x < 0:
		winning_player = 2
	elif pos.x > viewport_height:
		winning_player = 1
	return winning_player

func ballPosition(x, y):
	position = Vector2(x, y)
	
func _on_HUD_start_game():
	new_game = false
	
#func on_body_entered(body, player):
#	var player_size = player.get_node('Sprite').texture.get_size()
#	var player_pos = Vector2(int(round(player.position.x)), int(round(player.position.y)))
#	var ball_pos = Vector2(int(round(position.x)), int(round(position.y)))
#	print('Ball pos ' + str(ball_pos))
#	print('Player size ' + str(player_size))
#	print('Player pos ' + str(player_pos))
#	print(body)
#	var collision_point = (player_pos.y - ball_pos.y)/(player_size.y*0.5)
#	collision_angle = collision_point*90
#	print('Collision angle ' + str(collision_angle))
#	move_dir = Vector2(350, vertical_speed * collision_angle/100).normalized()
#	print(move_dir)
#	horizontal_vel = -horizontal_vel
#	body_entered = true
	



