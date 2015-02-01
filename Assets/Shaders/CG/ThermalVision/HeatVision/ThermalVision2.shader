Shader "Hidden/ThermalVision2" {
Properties {
	_MainTex ("Base (RGB)", 2D) = "white" {}
	_ColorAmplification("ColorAmplification",Range(0.1,0.9)) = 0.4
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
uniform float _ColorAmplification;
uniform half3 _Color1,_Color2;

// @link http://coding-experiments.blogspot.com.tr/2010/10/thermal-vision-pixel-shader.html
fixed4 frag (v2f_img i) : SV_Target
{	
	fixed4 finalColor;
  	half3 pixcol = tex2D(_MainTex, i.uv).rgb;
//  	float lum = (pixcol.r+pixcol.g+pixcol.b)/3.0;
//  	float lum = dot(vec3(0.30, 0.59, 0.11), pixcol.rgb);
	float lum = (0.2126*pixcol.r + 0.7152*pixcol.g + 0.0722*pixcol.b);
	half3 colors[3];
    colors[0] = half3(0.,0.,1.);
    colors[1] = half3(1.,1.,0.);
	half3 c = mix(colors[0],colors[1],lum/_ColorAmplification);
    finalColor.rgb = c+pixcol;
//    finalColor.g = mix(pixcol.rgb,_Color1,lum/1-_ColorAmplification).b;

  	return finalColor;
}
ENDCG

	}
}

Fallback off

}