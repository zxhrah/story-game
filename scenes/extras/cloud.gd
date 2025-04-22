extends Node2D

@export var cloud_texture: Texture2D
@export var cloud_count: int = 7  # Number of clouds (between 5–10)
@export var size_range: Vector2 = Vector2(0.1, 0.5)
@export var speed_range: Vector2 = Vector2(20.0, 60.0)

# Off-screen spawn range (to the left)
@export var x_range_offscreen: Vector2 = Vector2(-800, -700)
# On-screen spawn range (so it looks like clouds are already moving)
@export var x_range_onscreen: Vector2 = Vector2(0, 1700)

@export var y_range: Vector2 = Vector2(100, 250)
@export var x_reset_position: float = -200
@export var x_end_position: float = 1900

class Cloud:
	var node: Node2D
	var speed: float

func _ready():
	for i in cloud_count:
		var cloud = Node2D.new()
		var sprite = Sprite2D.new()
		sprite.texture = cloud_texture

		# Random scale
		var scale_factor = randf_range(size_range.x, size_range.y)
		sprite.scale = Vector2(scale_factor, scale_factor)

		cloud.add_child(sprite)
		add_child(cloud)

		# Half of clouds start on screen, others off screen
		var x_spawn = randf_range(x_range_onscreen.x, x_range_onscreen.y) if randf() < 0.5 else randf_range(x_range_offscreen.x, x_range_offscreen.y)
		cloud.position = Vector2(x_spawn, randf_range(y_range.x, y_range.y))

		# Save speed for this cloud
		cloud.set_meta("speed", randf_range(speed_range.x, speed_range.y))

func _process(delta):
	for cloud in get_children():
		if cloud.has_meta("speed"):
			var speed = cloud.get_meta("speed")
			cloud.position.x += speed * delta

			if cloud.position.x > x_end_position:
				cloud.position.x = x_reset_position
				cloud.position.y = randf_range(y_range.x, y_range.y)
