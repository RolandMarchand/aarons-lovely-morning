shader_type canvas_item;

void fragment() {
	COLOR.rgba = texture(TEXTURE, UV).grba;
}