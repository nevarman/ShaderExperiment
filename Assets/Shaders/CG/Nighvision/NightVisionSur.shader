Shader "Custom/NightVision" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_NoiseTex ("Noise (RGB)", 2D) = "white" {}
		_MaskTex ("Mask (RGB)", 2D) = "white" {}
		_LuminanceThreshold("LuminanceThreshold",Range(0.0,1.0)) = 0.2
		_ColorAmplification("ColorAmplification",Float) = 4.0
//		_EffectCoverage("EffectCoverage",Float) = 0.5
	}
	SubShader {
		Pass { ZTest Always Cull Off ZWrite Off
		Fog { Mode off } }
//		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _NoiseTex; 
		sampler2D _MaskTex; 
	 	half _ElapsedTime; // seconds
		half _LuminanceThreshold; // 0.2
		half _ColorAmplification; // 4.0
//		uniform half _EffectCoverage; // 0.5

		struct Input {
			float2 uv_MainTex;
			float2 uv_NoiseTex;
			float2 uv_MaskTex;
		};
/// Taken from here http://www.geeks3d.com/20091009/shader-library-night-vision-post-processing-filter-glsl/
		void surf (Input IN, inout SurfaceOutput o) {			
			half3 finalColor;
  			_ElapsedTime += _Time.y;
  			half2 uv;   
  			// shake uv with time for noise texture        
  			uv.x = 0.9*sin(_ElapsedTime*50.0);                                 
  			uv.y = 0.9*cos(_ElapsedTime*50.0);                                 
  			float mask = tex2D(_MaskTex, IN.uv_MaskTex).r;
  			half3 noise = tex2D(_NoiseTex,(IN.uv_NoiseTex*6) + uv).rgb;// noise texture(shaking a little)
  			half3 c = tex2D(_MainTex, IN.uv_MainTex).rgb;
  			
  			float lum = dot(half3(0.30, 0.59, 0.11), c);//dot product between our texColor and nightvision color(green)
  			if (lum < _LuminanceThreshold)c *= _ColorAmplification;// if it's below our treshold(darker), multiply it with a constant to brighten  
  			
  			half3 visionColor = half3(0.1, 0.95, 0.2);// green color for nightvision
  			finalColor = (c + (noise*0.2)) * visionColor * mask;

  			o.Albedo = finalColor;
		}
		ENDCG
	} 
	Fallback off
}
