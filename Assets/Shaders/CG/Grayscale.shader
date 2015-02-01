Shader "Custom/Grayscale" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Gray ("Gray", Range(0.1,1.0)) = 1.0
		//_Color ("Color", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		float _Gray;
		//fixed4 _Color; //a vec4 for RGBA

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);			
            //GRAYSCALE
            //create our sepia tone from some constant value
            half3 sepiaColor = half3(dot(c.rgb, half3(0.299, 0.587, 0.114)));
            c.rgb = mix(c.rgb, sepiaColor, _Gray);
            //final colour, multiplied by vertex colour           
            o.Albedo = c.rgb ;//*_Color;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
