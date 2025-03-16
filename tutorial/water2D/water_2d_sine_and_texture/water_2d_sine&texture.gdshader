shader_type canvas_item;

uniform float tiled_factor = 5.0;
uniform float aspect_ratio = 1.0;

uniform sampler2D uv_offset_texture: hint_default_black, repeat_enable;
uniform vec2 uv_offset_scale = vec2(1.0);
uniform float uv_offset_waves_sine = 0.1;
uniform vec2 time_scale = vec2(0.05, 0.08);

uniform float sine_time_scale = 1.0;
uniform vec2 sine_offset_scale = vec2(2.0, 2.0);
uniform vec2 sine_waves_size = vec2(0.05, 0.1);

vec2 calculate_waves_offset(float time, float multiplier, vec2 uv, vec2 scale) {
	vec2 offset;
	float time_multiplied = time * multiplier;
	float unique_offset = uv.x + uv.y;
	offset.x = cos(time_multiplied + unique_offset * scale.x);
	offset.y = sin(time_multiplied + unique_offset * scale.y);

	return offset;
}


void fragment() {
	vec2 tiled_uvs = UV * tiled_factor;
	tiled_uvs.y *= aspect_ratio;

	vec2 wave_uv_offets = calculate_waves_offset(TIME, sine_time_scale, tiled_uvs, sine_offset_scale);

	vec2 offset_texture_uv = UV * uv_offset_scale;
	offset_texture_uv += TIME * time_scale;

	vec2 texture_based_offset = texture(uv_offset_texture, offset_texture_uv).rg;
	texture_based_offset = texture_based_offset * 2.0 - 1.0;
	texture_based_offset *= uv_offset_waves_sine;

	COLOR = texture(TEXTURE, tiled_uvs + wave_uv_offets * sine_waves_size + texture_based_offset);
}
