Shader "Hidden/NightVision" {
Properties {
	_MainTex ("Base (RGB)", 2D) = "white" {}
	_NoiseTex ("Noise (RGB)", 2D) = "white" {}
	_MaskTex ("Mask (RGB)", 2D) = "white" {}
	_LuminanceThreshold("LuminanceThreshold",Range(0.0,1.0)) = 0.3
	_ColorAmplification("ColorAmplification",Float) = 5.0
	_Zoom("Zoom",Float)=0.0
}
SubShader {
	Pass {
		ZTest Always Cull Off ZWrite Off
		Fog { Mode off }
				
CGPROGRAM
#pragma vertex vert_img
#pragma fragment frag
#pragma fragmentoption ARB_precision_hint_fastest 
#include "UnityCG.cginc"

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex; 
uniform sampler2D _MaskTex; 
uniform float _ElapsedTime; // seconds
uniform float _LuminanceThreshold; 
uniform float _ColorAmplification,_Zoom;

float positive(float x) {
    return 0.5*(x + abs(x));
}
float renorm(float x, float upper, float lower) {
    return 1.0-positive(1.0-positive((x-lower)/(upper-lower)));
}
fixed4 frag (v2f_img i) : SV_Target
{	
	fixed4 finalColor;
  	_ElapsedTime += _Time.y;
  	half2 uv;   
  	// shake uv with time for noise texture        
  	uv.x = 0.9*sin(_ElapsedTime*50.0);                                 
  	uv.y = 0.9*cos(_ElapsedTime*50.0);                                 
  	float mask = tex2D(_MaskTex, i.uv).r;
  	half3 noise = tex2D(_NoiseTex,(i.uv *6) + uv).rgb;// noise texture(shaking a little)
  	// zoom 
  	half2 cUv = half2(i.uv.x+0.125 * _Zoom,i.uv.y+0.125 * _Zoom)/(1.0+0.25*_Zoom);
  	half3 cColor = tex2D(_MainTex, cUv).rgb;
  	
  	float lum = (0.2126*cColor.r + 0.7152*cColor.g + 0.0722*cColor.b);//luminance value (determine brigthness, based on wikipedia)
  	// if the pixel is bright leave it bright
//  	if (lum < _LuminanceThreshold) c *= _ColorAmplification; // dont use if
	float x = lerp( _ColorAmplification, 1f, renorm(lum, _LuminanceThreshold+0.001, _LuminanceThreshold-0.001));
  	cColor *= x;
  	
  	half3 greenColor = half3(0.0, 1.0, 0.0);// green color for nightvision
  	finalColor.rgb = (cColor + (noise*0.2)) * greenColor * mask;
  	return finalColor;
}
// REFERENCES
// https://developer.valvesoftware.com/wiki/Vision_Nocturna#Nightvision_with_shaders
// http://www.geeks3d.com/20091009/shader-library-night-vision-post-processing-filter-glsl/
ENDCG
	}
}
Fallback off
}