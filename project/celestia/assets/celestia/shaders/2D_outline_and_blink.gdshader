shader_type canvas_item;
// Pixel outline
uniform bool outline_enabled = false;
uniform vec4 outline_color: source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform bool corner_pixel = false;
// Color blink
uniform vec4 blink_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float blink_value : hint_range(0.0, 1.0, 0.1);


void fragment() {
	vec4 base = texture(TEXTURE, UV);
	// Color blink
	COLOR = mix(base, blink_color, blink_value);
	COLOR.a = base.a;
	// Pixel outline
	if (outline_enabled) {
		if (!(base.a > 0.0)) {
			vec2 image_pixel_size = TEXTURE_PIXEL_SIZE;
			bool valid_side =
				texture(TEXTURE, UV + vec2(-image_pixel_size.x, 0)).a > 0.0 ||
				texture(TEXTURE, UV + vec2(image_pixel_size.x, 0)).a > 0.0 ||
				texture(TEXTURE, UV + vec2(0, -image_pixel_size.y)).a > 0.0 ||
				texture(TEXTURE, UV + vec2(0, image_pixel_size.y)).a > 0.0;
			bool valid_corner =
				texture(TEXTURE, UV + vec2(-image_pixel_size.x, -image_pixel_size.y)).a > 0.0 ||
				texture(TEXTURE, UV + vec2(image_pixel_size.x, -image_pixel_size.y)).a > 0.0 ||
				texture(TEXTURE, UV + vec2(-image_pixel_size.x, image_pixel_size.y)).a > 0.0 ||
				texture(TEXTURE, UV + vec2(image_pixel_size.x, image_pixel_size.y)).a > 0.0;
			if (valid_side || (corner_pixel && valid_corner)) {
				COLOR = outline_color;
			}
		}
	}
}
