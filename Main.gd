extends Node

export (PackedScene) var BallScene

signal created_ball

var first = true

func _ready():
	var Ball = BallScene.instance()
	Ball.ballPosition(512, 296)
	Ball.set_name('Ball')
	add_child(Ball)
	Ball.connect('game_over', self, '_on_Ball_game_over')
	emit_signal("created_ball")

func _on_Ball_game_over():
	$HUD.restart()
