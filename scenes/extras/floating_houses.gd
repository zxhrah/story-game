extends Node2D

@export var house_texture_1: Texture2D
@export var house_texture_2: Texture2D
@export var size_range: Vector2 = Vector2(0.4, 0.6)
@export var speed: float = 55.0
@export var y_position: float = 280
@export var x_spawn: float = 1500 # Start off-screen right
@export var x_end: float = -200 # End off-screen left


var current_house: Sprite2D = null
func _ready():
	spawn_house()
func spawn_house():
	if current_house:
		current_house.queue_free()
	current_house = Sprite2D.new()
	# Randomly choose one of the two textures
	current_house.texture = house_texture_1 if randf() < 0.5 else house_texture_2
	# Scale randomly
	var scale = randf_range(size_range.x, size_range.y)
	current_house.scale = Vector2(scale, scale)
	# Position off-screen left
	current_house.position = Vector2(x_spawn, y_position)
	add_child(current_house)
func _process(delta):
	if current_house:
		current_house.position.x -= speed * delta # Move left
		if current_house.position.x < x_end:
			spawn_house() # Spawn again when off-screen left
