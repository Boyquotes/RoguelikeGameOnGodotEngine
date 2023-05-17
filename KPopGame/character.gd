extends Node2D

@onready var bullet_scene = preload("res://bullet.tscn")

const SPEED = 300
var SCREEN_SIZE = DisplayServer.window_get_size()
var flip = false
var attack = false
var direction = 1

const DEFAULT_PLAYER_HEATH = 100
var player_heath = DEFAULT_PLAYER_HEATH


func _ready():
	PlayerState.player_position_changed($CharacterBody2D.global_position)
	$CharacterBody2D/AnimatedSprite2D.play("idle")
	PlayerState.connect("player_hurt_signal", hurt)



func _process(delta):
	pass

func _physics_process(delta):
	var velocity = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		velocity.x = 1
		direction = 1
		flip = true	
	elif Input.is_action_pressed("move_left"):
		velocity.x = -1
		direction = -1
		flip = false
	if Input.is_action_pressed("move_down"):
		velocity.y = 1
	if Input.is_action_pressed("move_up"):
		velocity.y = -1
	
	if velocity.length() > 0:
		$CharacterBody2D.velocity = velocity.normalized() * SPEED
		$CharacterBody2D/AnimatedSprite2D.flip_h = flip
		if flip:
			$CharacterBody2D/Marker2D.position = Vector2($CharacterBody2D/AnimatedSprite2D.position.x + 16, $CharacterBody2D/AnimatedSprite2D.position.y)
		else:
			$CharacterBody2D/Marker2D.position = Vector2($CharacterBody2D/AnimatedSprite2D.position.x - 16, $CharacterBody2D/AnimatedSprite2D.position.y)
		$CharacterBody2D.move_and_slide()
		$CharacterBody2D/AnimatedSprite2D.play("run")
		PlayerState.player_position_changed($CharacterBody2D.global_position)
	else:
		if Input.is_action_pressed("attack"):
			$CharacterBody2D/AnimatedSprite2D.play("attack")
		else:
			$CharacterBody2D/AnimatedSprite2D.flip_h = flip
			$CharacterBody2D/AnimatedSprite2D.play("idle_left")
		if Input.is_action_just_pressed("attack"):
			var bullet = bullet_scene.instantiate()
			bullet.set_current_position($CharacterBody2D/Marker2D.position, direction)
			$CharacterBody2D.add_child(bullet)
	


func hurt(harm):
	player_heath -= harm
	print(player_heath)
	if player_heath <= 0:
		queue_free()
	
