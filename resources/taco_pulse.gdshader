// Aaron's Lovely Morning. Godot video game.
// Copyright (C) 2022 moowool195@gmail.com
// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

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