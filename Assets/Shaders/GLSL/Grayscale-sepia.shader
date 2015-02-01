Shader "GLSL/Grayscale-Sepia" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Sepia ("Sephia Size", Range(-5.0,5.0)) = 0.75
	}
	 SubShader { 
      Pass { 
         GLSLPROGRAM 
		
		uniform sampler2D _MainTex; 
		uniform float _Sepia;
		varying vec4 vTexCoord ;
		uniform vec4 _Color; //a vec4 for RGBA
		const vec3 SEPIA = vec3(1.2, 1.0, 0.8); 
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
//           //1. VIGNETTE
//           
//           //determine center position
//           vec2 position = (gl_FragCoord.xy / resolution.xy) - vec2(0.5);
//           
//           //determine the vector length of the center position
//           float len = length(position);
//           
//           //use smoothstep to create a smooth vignette
//           float vignette = smoothstep(RADIUS, RADIUS-SOFTNESS, len);
//           
//           //apply the vignette with 50% opacity
//           texColor.rgb = mix(texColor.rgb, texColor.rgb * vignette, 0.5);
//           
           //2. GRAYSCALE
           
           //convert to grayscale using NTSC conversion weights
           float gray = dot(texColor.rgb, vec3(0.299, 0.587, 0.114));
           //3. SEPIA
           //create our sepia tone from some constant value
           vec3 sepiaColor = vec3(gray) * SEPIA ;
           //again we'll use mix so that the sepia effect is at 75%
           texColor.rgb = mix(texColor.rgb, sepiaColor, _Sepia);
           //final colour, multiplied by vertex colour
           gl_FragColor = texColor * _Color;
		}
		 
         #endif // here ends the definition of the fragment shader
 
         ENDGLSL // here ends the part in GLSL 
      }
   }
   Fallback "Diffuse"
}
