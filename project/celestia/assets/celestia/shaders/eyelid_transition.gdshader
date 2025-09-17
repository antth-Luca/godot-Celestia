shader_type canvas_item;

uniform float open_amount : hint_range(0.0, 1.0) = 0.0;
uniform vec2 center = vec2(0.5, 0.5);
uniform float smoothness : hint_range(0.0, 0.2) = 0.08;

void fragment() {
	vec2 uv = UV;
	float y = abs(uv.y - center.y);
	float half_open = mix(0.0, 1.0, open_amount);
	float curve = pow(abs(uv.x - center.x) * 2.0, 2.0) * 0.5;
	float edge = half_open - curve;
	float mask = smoothstep(edge - smoothness, edge + smoothness, y);
	COLOR = vec4(0.0, 0.0, 0.0, mask);
}
