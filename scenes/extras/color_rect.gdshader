	shader_type canvas_item;

	uniform float time;
	uniform float amplitude = 5.0;
	uniform float frequency = 20.0;
	uniform float speed = 2.0;
	uniform float border_thickness = 0.005;

	void fragment() {
	    vec2 uv = UV;

	    // Combined sine waves for more natural variation
	    float wave =
	        sin(uv.x * frequency + time * speed) +
	        0.5 * sin(uv.x * (frequency * 0.5) + time * speed * 1.3);

	    // Round out the wave
	    wave = pow(abs(wave), 1.5) * sign(wave);
	    wave *= amplitude / 100.0;

	    // Create a smooth alpha transition for the main wave
	    float wave_alpha = smoothstep(wave - 0.01, wave + 0.01, uv.y);

	    // Add a thin white border at the top of the wave
	    float border = smoothstep(wave - border_thickness, wave, uv.y)
	                 - smoothstep(wave, wave + border_thickness, uv.y);

	    // Mix water color and border color
	    vec4 water_color = vec4(0.2, 0.6, 1.0, 0.5 * wave_alpha);
	    vec4 border_color = vec4(1.0, 1.0, 1.0, border); // White

	    COLOR = mix(water_color, border_color, border);
	}