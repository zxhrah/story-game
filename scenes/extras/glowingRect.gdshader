shader_type canvas_item;

uniform float time;

void fragment() {
	vec2 uv = UV * 2.0 - 1.0;
	float glow = 1.0 - smoothstep(0.0, 0.3, abs(uv.x));
	glow *= 0.8 + 0.2 * sin(TIME * 3.0);  // Slight pulsing
	COLOR = vec4(vec3(glow), glow);
}
