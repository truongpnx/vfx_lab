shader_type canvas_item;

uniform vec2 tiled_factor = vec2(5.0, 5.0);
uniform float aspect_ratio = 1.0;

uniform vec2 time_scale = vec2(1.0, 1.0);
uniform vec2 offset_scale = vec2(2.0, 2.0);
uniform vec2 waves_size = vec2(0.05, 0.1);

void fragment() {
	vec2 tiled_uvs = UV * tiled_factor;
	tiled_uvs.y *= aspect_ratio;

	vec2 wave_uv_offets;
	wave_uv_offets.x = cos(TIME * time_scale.x + (tiled_uvs.x + tiled_uvs.y) * offset_scale.x);
	wave_uv_offets.y = sin(TIME * time_scale.y + (tiled_uvs.x + tiled_uvs.y) * offset_scale.y);

	//COLOR = vec4(tiled_uvs, 0.0, 1.0);
	//COLOR = vec4(wave_uv_offets / 0.05, 0.0, 1.0);
	COLOR = texture(TEXTURE, tiled_uvs + wave_uv_offets * waves_size);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
