extends Control

signal start_game

var time_left = 0
var start_pressed = false
var iterate = false

func _ready():
	$CountdownNmb.visible = false
	$CountdownTxt.visible = false
	
func _process(_delta):
	if start_pressed == true:
		$StartButton.visible = false
		text_func()
	
func _on_Button_pressed():
	time_left = 3
	start_pressed = true
	$Timer.start()

func _on_Timer_timeout():
	time_left -= 1
	$Timer.start()
	
func text_func():
	if time_left == 3:
		$CountdownNmb.visible = true
		$CountdownTxt.visible = true	
	elif time_left == 2:
		$CountdownNmb.text = '2'
		$CountdownTxt.text = 'Set..'
	elif time_left == 1:
		$CountdownNmb.text = '1'
		$CountdownTxt.text = 'GO!!'
	elif time_left == 0:
		$CountdownNmb.visible = false
		$CountdownTxt.visible = false
		$CountdownNmb.text = '3'
		$CountdownTxt.text = 'Ready..'
		start_pressed = false

		emit_signal('start_game')
		
func restart():
	$WinningPlayer.visible = true
	$WinningPlayer.text = 'Player ' + str(get_node('../Ball').winningplayer()) + ' won!'
	$DeathTimer.start()
	
func _on_DeathTimer_timeout():
	get_tree().reload_current_scene()
