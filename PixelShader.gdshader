shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform int amount = 40;

void fragment()
{
	vec2 grid_uv = round(UV * float(amount)) / float(amount);
	
	vec4 text = texture(screen_texture, grid_uv);
	
	COLOR = text;
}

