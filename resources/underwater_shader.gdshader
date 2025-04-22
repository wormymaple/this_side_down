shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D noise0 : repeat_enable;
uniform sampler2D noise1;
uniform float intensity;
uniform float timeMultiplier;

void fragment() {
	vec2 noise = vec2(texture(noise0, UV + TIME * timeMultiplier).x, texture(noise1, UV + TIME * timeMultiplier).x);
	vec3 sample = texture(screen_texture, SCREEN_UV + noise * intensity).xyz;
    vec4 col = vec4(sample.r, sample.g, sample.b, 1);

    COLOR.rgba = col;
}