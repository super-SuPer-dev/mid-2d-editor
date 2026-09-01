shader_type canvas_item;
render_mode unshaded;

uniform float alpha_cutoff : hint_range(0.0, 1.0, 0.001) = 0.02;

void fragment() {
	vec4 pixel = texture(TEXTURE, UV) * COLOR;
	if (pixel.a <= alpha_cutoff) {
		discard;
	}
	COLOR = pixel;
}
