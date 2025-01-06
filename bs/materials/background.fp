varying mediump vec2 var_texcoord0;

void main()
{
	gl_FragColor = mix(vec4(0.2, 0.15, 0.85, 1), vec4(0.557, 0.15, 0.886, 1), var_texcoord0.y);
}
