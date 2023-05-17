extends Node2D

var player_position = Vector2(0, 0)

signal player_position_signal(player_position)
signal player_hurt_signal(harm)

func player_hurt(harm):
	emit_signal("player_hurt_signal", harm)

func player_position_changed(position):
	player_position = position
	emit_player_position_changed()

func emit_player_position_changed():
	emit_signal("player_position_signal", player_position)

