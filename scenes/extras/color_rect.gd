extends ColorRect

@onready var shader_mat := self.material as ShaderMaterial
var time := 0.0

func _process(delta):
	time += delta
	shader_mat.set_shader_parameter("time", time)
