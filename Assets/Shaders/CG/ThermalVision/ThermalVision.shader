Shader "Hidden/ThermalVision" {
Properties {
	_MainTex ("Base (RGB)", 2D) = "white" {}
	_NoiseTex ("Noise (RGB)", 2D) = "white" {}
	_ColorAmplification("ColorAmplification",Range(0.1,0.9)) = 0.6
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

fixed4 frag (v2f_img i) : SV_Target
{	
	fixed4 finalColor;
  	half3 pixcol = tex2D(_MainTex, i.uv).rgb;
//  	float lum = (pixcol.r+pixcol.g+pixcol.b)/3.0;
//  	float lum = dot(vec3(0.30, 0.59, 0.11), pixcol.rgb);
	float lum = (0.2126*pixcol.r + 0.7152*pixcol.g + 0.0722*pixcol.b);

    // @link http://coding-experiments.blogspot.com.tr/2010/10/thermal-vision-pixel-shader.html
    finalColor.rgb = mix((1.0,1.0,0.0),(0.0,0.0,1.0),lum/_ColorAmplification);

  	return finalColor;
}
ENDCG

	}
}

Fallback off

}