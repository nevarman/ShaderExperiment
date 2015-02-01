Shader "Custom/Blur" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
        _Blur ("Blur Size", Range(0.0,10.0)) = 2.0
        _BlurX ("Blur Dir X", Range(0.0,1.0)) = 1.0
        _BlurY ("Blur Dir Y", Range(0.0,1.0)) = 1.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		uniform float _Blur;
		uniform float _BlurX;//horizontal blur
		uniform float _BlurY;//vertical blur

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
		
			float blur = _Blur /1024.0;
			float2 vTexCoord = IN.uv_MainTex;
			half4 sum;
		    // take nine samples, with the distance blurSize between them
		    sum += tex2D(_MainTex, vec2(vTexCoord.x - 4.0*blur*_BlurX, vTexCoord.y- 4.0*blur*_BlurY)) * 0.0162162162;
		    sum += tex2D(_MainTex, vec2(vTexCoord.x - 3.0*blur*_BlurX, vTexCoord.y- 3.0*blur*_BlurY)) * 0.0540540541;
		    sum += tex2D(_MainTex, vec2(vTexCoord.x - 2.0*blur*_BlurX, vTexCoord.y- 2.0*blur*_BlurY)) * 0.1216216216;
		    sum += tex2D(_MainTex, vec2(vTexCoord.x - 1.0*blur*_BlurX, vTexCoord.y- 1.0*blur*_BlurY)) * 0.1945945946;
		    sum += tex2D(_MainTex, vec2(vTexCoord.x, vTexCoord.y)) * 0.2270270270;
		    sum += tex2D(_MainTex, vec2(vTexCoord.x + 1.0*blur*_BlurX, vTexCoord.y + 1.0*blur*_BlurY)) * 0.1945945946;
		    sum += tex2D(_MainTex, vec2(vTexCoord.x + 2.0*blur*_BlurX, vTexCoord.y + 2.0*blur*_BlurY)) * 0.1216216216;
		    sum += tex2D(_MainTex, vec2(vTexCoord.x + 3.0*blur*_BlurX, vTexCoord.y + 3.0*blur*_BlurY)) * 0.0540540541;
		    sum += tex2D(_MainTex, vec2(vTexCoord.x + 4.0*blur*_BlurX, vTexCoord.y + 4.0*blur*_BlurY)) * 0.0162162162;
			
//			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = sum.rgb;//c.rgb;
			o.Alpha = sum.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
