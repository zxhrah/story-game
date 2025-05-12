extends ColorRect

@onready var shader_mat := self.material as ShaderMaterial
var time := 0.0 # Tracks shader time elapsed 
var time_multiplier := 1.0

func _process(delta):
	time += delta * time_multiplier # Increments time based on frames duration and speed
	shader_mat.set_shader_parameter("time", time) # Updates shader time
