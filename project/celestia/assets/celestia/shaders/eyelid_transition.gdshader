shader_type canvas_item;

uniform float open_amount : hint_range(0.0, 1.0) = 0.0; // 0 = fechado, 1 = aberto
uniform vec2 center = vec2(0.5, 0.5); // centro da tela em UV
uniform float smoothness : hint_range(0.0, 0.2) = 0.08; // borda suave

void fragment() {
    vec2 uv = UV;
    float y = abs(uv.y - center.y); // distância vertical ao centro
    
    // Altura da abertura proporcional a open_amount
    float half_open = mix(0.0, 1.0, open_amount);

    // Forma curvada: quanto mais longe do centro X, mais fecha
    float curve = pow(abs(uv.x - center.x) * 2.0, 2.0) * 0.5;

    // Limite entre preto e transparente
    float edge = half_open - curve;

    // Transição suave
    float mask = smoothstep(edge - smoothness, edge + smoothness, y);

    // Preto fora da abertura, transparente dentro
    COLOR = vec4(0.0, 0.0, 0.0, mask);
}
