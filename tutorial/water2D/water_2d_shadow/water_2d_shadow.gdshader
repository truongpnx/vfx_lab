shader_type canvas_item;

uniform vec4 shadow_color: source_color;

uniform float tiled_factor = 5.0;
uniform float aspect_ratio = 1.0;

uniform sampler2D texture_offset_uv: hint_default_black, repeat_enable;
uniform vec2 uv_offset_scale = vec2(1.0);
uniform float texture_offset_height = 0.1;
uniform vec2 uv_time_scale = vec2(0.05, 0.08);

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

	vec2 base_uv_offset = UV * uv_offset_scale;
	base_uv_offset += TIME * uv_time_scale;

	vec2 texture_based_offset = texture(texture_offset_uv, base_uv_offset).rg * 2.0 - 1.0;
	vec2 wave_uv_offset = calculate_waves_offset(TIME, sine_time_scale, tiled_uvs, sine_offset_scale);
	vec2 waves_uv = tiled_uvs + wave_uv_offset * sine_waves_size + texture_based_offset * texture_offset_height;
	
	float waves_height = (texture_based_offset.y*0.5 + wave_uv_offset.y) * 0.25 + 0.5;
	//waves_height = min(waves_height * 1.5, 1.0);

	vec4 diffuse_color = texture(TEXTURE, waves_uv);
	COLOR = mix(shadow_color * diffuse_color, diffuse_color, waves_height);
	//COLOR = texture(TEXTURE, vec2(waves_height, waves_height));
	NORMAL = texture(NORMAL_TEXTURE, waves_uv / 5.0).rgb;
}
