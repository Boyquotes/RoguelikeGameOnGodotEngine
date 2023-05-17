extends Node2D

const SPEED = 400

var direction = -1


func _physics_process(delta):
	$bullet.velocity =  Vector2(1, 0).normalized() * direction * SPEED
	$bullet.move_and_slide()
	for i in range($bullet.get_slide_collision_count()):
		var collision = $bullet.get_slide_collision(i)
		var collider = collision.get_collider()
		if "Enemy" in collider.name:
			queue_free()

func set_current_position(_position, _direction):
	position = _position	
	direction = _direction



func _on_timer_timeout():
	queue_free()
