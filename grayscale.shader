shader_type canvas_item;
uniform bool grayscale;
uniform float grayscaleFactor = 3; //The higher this is, the darker the image becomes.

void fragment(){
	COLOR = texture(TEXTURE, UV);
	if (grayscale){
		COLOR.rgb = vec3((0.2126*COLOR.r + 0.7152*COLOR.g + 0.0722*COLOR.b) / grayscaleFactor);
	} 
}