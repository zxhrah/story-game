extends ColorRect

@onready var shader_mat := self.material as ShaderMaterial
var time := 0.0
var time_multiplier := 1.0  # You can tweak this per ColorRect if needed

func _process(delta):
	time += delta * time_multiplier
	shader_mat.set_shader_parameter("time", time)
