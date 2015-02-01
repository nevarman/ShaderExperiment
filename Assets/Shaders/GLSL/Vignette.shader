Shader "GLSL/Vignette" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Radius ("Radius",Range(0.2,1.0)) = 0.75
		_Softness ("Softness", Range(0.0,0.75)) = 0.45
	}
	 SubShader { 
      Pass { 
         GLSLPROGRAM 
		
		uniform sampler2D _MainTex; 
		uniform float _Radius;
		uniform float _Softness;
		varying vec4 vTexCoord ;
		uniform vec4 _Color; //a vec4 for RGBA
		vec4 texColor = vec4(0.0);
		
        #ifdef VERTEX // here begins the vertex shader
 		
		void main(void)
		{
  		   vTexCoord = gl_MultiTexCoord0;
		   gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
		}
 
         #endif // here ends the definition of the vertex shader

         #ifdef FRAGMENT // here begins the fragment shader
 		
		void main(void)
		{
		  
		   //sample our texture
    	   texColor = texture2D(_MainTex, vec2(vTexCoord));
           // VIGNETTE
           
           //determine center position
           vec2 position = (vTexCoord.xy) - vec2(0.5);
           
           //determine the vector length of the center position
           float len = length(position);
           
           //use smoothstep to create a smooth vignette
           float vignette = smoothstep(_Radius, _Radius-_Softness, len);
           
           //apply the vignette with 50% opacity
           texColor.rgb = mix(texColor.rgb, texColor.rgb * vignette, 0.5);
           gl_FragColor = texColor * _Color;
		}
		 
         #endif // here ends the definition of the fragment shader
 
         ENDGLSL // here ends the part in GLSL 
      }
   }
   Fallback "Diffuse"
}
