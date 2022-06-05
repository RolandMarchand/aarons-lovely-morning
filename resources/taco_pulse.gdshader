shader_type canvas_item;

uniform sampler2D curve;
uniform float strength;

void fragment() {
	vec2 vec2center = vec2(0.5, 0.5) - UV;
	float dist2center = length(vec2center);
	float curve_val = texture(curve, vec2(dist2center)).r;
	vec2 diff = normalize(vec2center) * strength * curve_val;
	
	COLOR = textureLod(SCREEN_TEXTURE, SCREEN_UV - diff, 0.0);
	COLOR.a = texture(TEXTURE, UV).a;
}