shader_type canvas_item;

uniform float tiled_factor = 1.0;
uniform float aspect_ratio = 1.0;

uniform sampler2D uv_offset_texture: hint_default_black, repeat_enable;
uniform vec2 uv_offset_scale = vec2(1.0);
uniform vec2 wave_size = vec2(0.1);
uniform float time_scale = 0.05;

void fragment() {

	vec2 offset_texture_uv = UV * uv_offset_scale;
	offset_texture_uv += TIME * time_scale;

	vec2 texture_based_offset = texture(uv_offset_texture, offset_texture_uv).rg;
	texture_based_offset = texture_based_offset * 2.0 - 1.0;

	vec2 adjusted_uv = UV * tiled_factor;
	adjusted_uv.y *= aspect_ratio;

	COLOR = texture(TEXTURE, adjusted_uv + texture_based_offset * wave_size);
	NORMAL_MAP = texture(NORMAL_TEXTURE, UV + texture_based_offset * 0.5).rgb;
	//COLOR = vec4(texture_based_offset, vec2(0.0, 1.0));

}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
