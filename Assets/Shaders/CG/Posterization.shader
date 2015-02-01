Shader "Custom/Posterization" {
Properties {
	_MainTex ("Base (RGB)", 2D) = "white" {}
	_Gamma("Gamma",Range(0.1,1.0)) = 0.6
	_NumColors("Number of Colors",Float) = 8.0
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
uniform float _Gamma; // 0.6
uniform float _NumColors; // 8.0

fixed4 frag (v2f_img i) : SV_Target
{	
	fixed4 finalColor;
  	half3 c = tex2D(_MainTex, i.uv);
  	c = pow(c, half3(_Gamma, _Gamma, _Gamma));
  	c = c * _NumColors;
  	c = floor(c);
  	c = c / _NumColors;
  	c = pow(c, half3(1.0/_Gamma));
  	finalColor.rgb = c;
  	return finalColor;
}
ENDCG

	}
}

Fallback off

}