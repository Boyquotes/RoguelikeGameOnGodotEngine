extends Node2D

var rng = RandomNumberGenerator.new()
var box = preload("res://box.tscn")

func _ready():
	pass
	#call_deferred("generate")

func generate():

	var windows_size = DisplayServer.window_get_size()
	var x = windows_size.x
	var y = windows_size.y
	var x_tiles = ceil(x / 32) * 8
	var y_tiles = ceil(y / 32) * 8
	var map = Array()
	for i in range(y_tiles):
		var row = Array()
		for j in range(x_tiles):
			row.append(j)
		map.append(row)

	for i in range(y_tiles):
		for j in range(x_tiles):
			var choise = random_bool()
			if   map[i][j] != -1 && j != x_tiles - 1 && (choise || map[i][j] == map[i][j + 1]):
				if j != x_tiles - 2:
					map[i][j + 1] = -1
			elif j != x_tiles - 1 && map[i][j] != -1:
				map[i][j + 1] = map[i][j]
		if i < y_tiles - 3:
			for j in range(x_tiles):
				var choise = random_bool()
				if choise && calculate_unique_set(map[i], map[i][j], x_tiles) > 1:
					map[i + 1][j] = -1

		
func random_bool():
	var value = rng.randi_range(0, 1)
	if value == 1:
		return true
	return false

func calculate_unique_set(row, value, x_tiles):
	var result = 0
	for j in range(x_tiles):
		if row[j] == value:
			result = result + 1
	return result
		
		
func create_static_body(position):
	var box_instance = box.instantiate()
	box_instance.global_position = Vector2(position.x + 16, position.y + 16)
	add_child(box_instance)
