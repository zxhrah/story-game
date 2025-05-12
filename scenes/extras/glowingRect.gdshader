shader_type canvas_item;

uniform float time;

void fragment() {
    vec2 uv = UV * 2.0 - 1.0;
    float glow = 1.0 - smoothstep(0.0, 0.3, abs(uv.x));
    float pulse = 0.5 + 0.5 * sin(TIME * 2.0);
    glow *= pulse;
    COLOR = vec4(vec3(1.0), glow); // Always white, just fades

}
