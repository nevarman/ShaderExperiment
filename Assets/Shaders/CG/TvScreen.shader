Shader "Custom/TVScreen" {
	Properties {
		_Tint ("Tint Color", Color) = (0.8,1.0,0.7)
		_MainTex ("Base (RGB)", 2D) = "white" {}
    	_Blend ("Blending", Range(0,1)) = 0
    	_Distortion ("Line Distortion", Range(100,1000)) = 100
    	_LineSpeed("Line Distortion Speed", Range(1,10)) = 10
    	_Flicker ("Flickering", Range(100,1000)) = 100
    	
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert
		
		sampler2D _MainTex;
		fixed4 _Tint;
		uniform float _Blend; 
		half _Distortion,_LineSpeed,_Flicker;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			half3 col = c.rgb;
			col = clamp(col*0.5+0.5*col*3.2,0.0,1.0);				
			col *= _Tint;
		    col *= 0.9+0.1*sin(_LineSpeed*_Time.y+IN.uv_MainTex.y*_Distortion);//LineMotion
			col *= 0.97+0.03*sin(_Flicker*_Time.y);// Flicker
			col = mix( col, c, _Blend );
			
			o.Albedo = col;
			o.Alpha = c.a;
		}
		ENDCG
	}
	 
	FallBack "Diffuse"
}
