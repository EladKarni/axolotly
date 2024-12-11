shader_type spatial;
render_mode unshaded;

uniform sampler2D noise : repeat_enable;

void fragment(){
	vec4 noise_col = texture(noise, UV);
}