shader_type canvas_item;

uniform vec4 blink_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float blink_value : hint_range(0.0, 1.0, 0.1);

void fragment() {
	vec4 sprite_color = texture(TEXTURE, UV);
	COLOR = mix(sprite_color, blink_color, blink_value);
	COLOR.a = sprite_color.a;
}
