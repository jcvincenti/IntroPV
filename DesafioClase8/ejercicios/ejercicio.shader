shader_type canvas_item;

uniform float width = 0.01;
uniform float progress : hint_range(0.1,0.9) = 0.5;
uniform vec4 color_min : hint_color;
uniform vec4 color_max : hint_color;

// Retorna la distancia al segmento
float sdSegment( in vec2 p, in vec2 a, in vec2 b )
{
    vec2 pa = p-a, ba = b-a;
    float h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
	return length( pa - ba*h );
}

void fragment() {
	float grayscale = sdSegment(UV, vec2(0.1, 0.5), vec2(0.9, 0.5));
	vec3 background = vec3(1.0 - smoothstep(width, width + 0.01, grayscale));
	float grayscale_progress = sdSegment(UV, vec2(0.1, 0.5), vec2(progress, 0.5));
	vec3 background_progress = vec3(1.0 - smoothstep(width, width + 0.01, grayscale_progress));
	vec3 bar_color = mix(color_min.rgb, color_max.rgb, progress);
	vec3 bar = mix(background, bar_color.rgb, background_progress);
	COLOR = vec4(bar, 1.0);
}