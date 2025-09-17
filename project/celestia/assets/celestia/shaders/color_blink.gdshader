shader_type canvas_item;

uniform vec4 blink_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform bool is_blink = false;

void fragment() {
    vec4 sprite_color = texture(TEXTURE, UV);
    vec3 final_rgb = is_blink ? blink_color.rgb : sprite_color.rgb;
    COLOR = vec4(final_rgb, sprite_color.a);
}
