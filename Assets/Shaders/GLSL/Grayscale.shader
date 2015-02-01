Shader "GLSL/Grayscale" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	 SubShader { 
	 Tags { "Queue" = "Geometry" }
      Pass { 
         GLSLPROGRAM 
		
		uniform sampler2D _MainTex; 
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
 
         #endif 

         #ifdef FRAGMENT
 		
		void main(void)
		{
		   //sample our texture
    	   texColor = texture2D(_MainTex, vec2(vTexCoord));
           //GRAYSCALE
           //create our sepia tone from some constant value
           vec3 sepiaColor = vec3(dot(texColor.rgb, vec3(0.299, 0.587, 0.114)));
           texColor.rgb = mix(texColor.rgb, sepiaColor, 1.0);
           //final colour, multiplied by vertex colour
           gl_FragColor = texColor * _Color;
		}
		 
         #endif 
 
         ENDGLSL 
      }
   }
   Fallback "Diffuse"
}
