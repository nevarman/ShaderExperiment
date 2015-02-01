Shader "GLSL/Gaussian Blur-Alpha" {
 	Properties {
        _MainTex ("Base", 2D) = "white" {}
        _Cutoff("Cut off",Float) = 0.5
        _Blur ("Blur Size", Float) = 2.0
        _BlurX ("Blur Dir X", Float) = 1.0
        _BlurY ("Blur Dir Y", Float) = 0.0
    }

	 SubShader { // Unity chooses the subshader that fits the GPU best
	 Tags { "Queue" = "Transparent" } 
         // draw after all opaque geometry has been drawn
      Pass {
         ZWrite Off // don't write to depth buffer 
            // in order not to occlude other objects
 
         Blend SrcAlpha OneMinusSrcAlpha // use alpha blending
 
         GLSLPROGRAM // here begins the part in Unity's GLSL
		
		uniform sampler2D _MainTex; // the texture with the scene you want to blur
		uniform float _Blur;
		uniform float _Cutoff;
		uniform float _BlurX;//horizontal blur
		uniform float _BlurY;//vertical blur
		varying vec4 vTexCoord ;
		vec4 sum = vec4(0.0);
			 
        #ifdef VERTEX // here begins the vertex shader
 		
		void main(void)
		{
//		   gl_Position = ftransform();
  		   vTexCoord = gl_MultiTexCoord0;
//		   vec2 Pos;
//		   Pos = sign(gl_Vertex.xy);
//		   gl_Position = gl_ModelViewProjectionMatrix *vec4(Pos, 0.0, 2.0);
		   gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
//		   // Image-space
//		   vTexCoord = gl_MultiTexCoord0;//Pos * 0.5 + 0.5;
		}
 
         #endif // here ends the definition of the vertex shader

         #ifdef FRAGMENT // here begins the fragment shader
 		
		void main(void)
		{
		   //got this part from here! https://github.com/mattdesl/lwjgl-basics/wiki/ShaderLesson5
		   float blur = _Blur /1024.0;
		   // take nine samples, with the distance blurSize between them
		   sum += texture2D(_MainTex, vec2(vTexCoord.x - 4.0*blur*_BlurX, vTexCoord.y- 4.0*blur*_BlurY)) * 0.0162162162;
		   sum += texture2D(_MainTex, vec2(vTexCoord.x - 3.0*blur*_BlurX, vTexCoord.y- 3.0*blur*_BlurY)) * 0.0540540541;
		   sum += texture2D(_MainTex, vec2(vTexCoord.x - 2.0*blur*_BlurX, vTexCoord.y- 2.0*blur*_BlurY)) * 0.1216216216;
		   sum += texture2D(_MainTex, vec2(vTexCoord.x - 1.0*blur*_BlurX, vTexCoord.y- 1.0*blur*_BlurY)) * 0.1945945946;
		   sum += texture2D(_MainTex, vec2(vTexCoord.x, vTexCoord.y)) * 0.2270270270;
		   sum += texture2D(_MainTex, vec2(vTexCoord.x + 1.0*blur*_BlurX, vTexCoord.y + 1.0*blur*_BlurY)) * 0.1945945946;
		   sum += texture2D(_MainTex, vec2(vTexCoord.x + 2.0*blur*_BlurX, vTexCoord.y + 2.0*blur*_BlurY)) * 0.1216216216;
		   sum += texture2D(_MainTex, vec2(vTexCoord.x + 3.0*blur*_BlurX, vTexCoord.y + 3.0*blur*_BlurY)) * 0.0540540541;
		   sum += texture2D(_MainTex, vec2(vTexCoord.x + 4.0*blur*_BlurX, vTexCoord.y + 4.0*blur*_BlurY)) * 0.0162162162;

		   gl_FragColor = sum * _Cutoff;
		}
		 
         #endif // here ends the definition of the fragment shader
 
         ENDGLSL // here ends the part in GLSL 
      }
   }
   Fallback "Diffuse"
}