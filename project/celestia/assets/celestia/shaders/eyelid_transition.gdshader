shader_type canvas_item;

uniform float open_amount : hint_range(0.0, 1.0) = 0.0; // 0 = fechado, 1 = aberto
uniform vec2 center = vec2(0.5, 0.5); // centro da tela (em UVs)
uniform vec2 aspect = vec2(1.0, 0.6); // deformação para oval (simula olhos)

void fragment() {
    vec2 uv = UV;
    
    // Centraliza
    vec2 pos = uv - center;
    
    // Aplica aspecto oval
    pos /= aspect;
    
    float dist = length(pos);
    
    // Raio da abertura baseado em open_amount
    float radius = mix(0.0, 0.8, open_amount);
    
    // Se fora do círculo, pinta preto
    if (dist > radius) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);
    } else {
        COLOR = vec4(0.0, 0.0, 0.0, 0.0); // transparente (mostra a cena)
    }
}
