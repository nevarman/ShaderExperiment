Shader "Custom/Shock" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Center ("Center", Vector) = (0,0,0,0) 
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		float _WaveTime;
		float4 _Center;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half2 uv = IN.uv_MainTex.xy;
 			half2 _textCord = uv;
 			float _distance = distance(uv, _Center);
 			if ( (_distance <= (_WaveTime + 0.1)) && (_distance >= (_WaveTime - 0.1)) ) 
 			{
 			  float diff = (_distance - _WaveTime); 
 			  float powDiff = 1.0 - pow(abs(diff*10.0),0.8); 
 			  float diffTime = diff  * powDiff; 
 			  half2 diffUV = normalize(uv - _Center); 
 			  _textCord = uv + (diffUV * diffTime);
 			} 
 			half4 c = tex2D(_MainTex, _textCord);
 			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
