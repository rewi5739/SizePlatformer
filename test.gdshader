shader_type canvas_item;

//this allows for editing value in the texture
//make shader local to scene
// hint range is gd specific way to godot, makes a slider at the bottom of the editor. 
//go to Inspector>Texture>repeat to make it repeat.
uniform float scale: hint_range(0.0, 1.0, 0.1) = 1.0;
uniform vec4 mod_color : source_color;

uniform float flash : hint_range(0.0, 1.0, 0.1) = 0.0;

//Sampler2d = image texture
uniform sampler2D screen_texture : hint_screen_texture;

//need to interact with inspector to make this work.
uniform sampler2D noise_texture : repeat_disable;

//void fragment() {
	////uv is the original texture's current coordinates
	////Texture is the reference to the texture
	////Color is the color thing
	//vec2 distortedUV = UV;
	//distortedUV.x += UV.y*1.4;
	//vec4 pixelColor = texture(TEXTURE, distortedUV);
	 //COLOR = pixelColor;
//}

//void fragment() {
	//vec4 pixelColor = texture(TEXTURE, UV);
	//float value = (pixelColor.r + pixelColor.g + pixelColor.b) / 3.0;
	////COLOR = vec4(value, value, value,pixelColor.a);
	////COLOR.rgb = pixelColor.brb;
	//COLOR = pixelColor * mod_color;
//}

//void fragment() {
	////Example of how to implement flashing colors on the image.
	//vec4 pixelColor = texture(TEXTURE, UV);
	//COLOR = mix(pixelColor, vec4(1), flash);
	//COLOR.a= pixelColor.a;
//}


//void fragment() {
	////like a decoder ring, can change the color of the shit under it
	////vec4 pixelColor = texture(screen_texture, SCREEN_UV);
	////COLOR.rgba = pixelColor.bgra;
	//
	//vec2 distortedUV = SCREEN_UV + texture(TEXTURE, UV).r * 0.1;
	//vec4 pixelColor = texture(screen_texture, distortedUV);
	//COLOR = pixelColor;
//}

void fragment() {
	//used for distortions and such, glass and water like things
	
	
	vec2 distortedUV = SCREEN_UV + texture(noise_texture, UV + TIME).r * 0.1;
	vec4 pixelColor = texture(screen_texture, distortedUV);
	COLOR = pixelColor;
}