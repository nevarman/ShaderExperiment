Shader "Custom/DreamVision" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			
			half2 uv = IN.uv_MainTex.xy;
  			half4 c = tex2D(_MainTex, uv);
  			
  			c += tex2D(_MainTex, uv+0.001);
  			c += tex2D(_MainTex, uv+0.003);
  			c += tex2D(_MainTex, uv+0.005);
  			c += tex2D(_MainTex, uv+0.007);
  			c += tex2D(_MainTex, uv+0.009);
  			c += tex2D(_MainTex, uv+0.011);
  			
  			c += tex2D(_MainTex, uv-0.001);
  			c += tex2D(_MainTex, uv-0.003);
  			c += tex2D(_MainTex, uv-0.005);
  			c += tex2D(_MainTex, uv-0.007);
  			c += tex2D(_MainTex, uv-0.009);
  			c += tex2D(_MainTex, uv-0.011);
  			
  			c.rgb = vec3((c.r+c.g+c.b)/3.0);
  			c = c / 9.5;
  			o.Albedo = c.rgb;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
