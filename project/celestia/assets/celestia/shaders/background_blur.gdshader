shader_type canvas_item;

uniform float lod: hint_range(0.0, 4.0) = 1.0; // quanto maior, mais embaçado
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform vec4 tint_color : source_color = vec4(1.0, 1.0, 1.0, 1.0); // corzinha

void fragment(){
    // Pega a tela renderizada com o nível de embaçamento (mipmap level)
    vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV, lod);

    // Aplica a cor extra (tint)
    color.rgb *= tint_color.rgb;
    color.a *= tint_color.a;

    COLOR = color;
}
