Shader "Custom/Simple" {
	SubShader{
		Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }

		CGPROGRAM
		// couldn't find the reason why this does not correctly recieve shadows
		#pragma surface surf Lambert
		struct Input {
			// Input structure should not be empty (size should not be 0)
			fixed4 color : COLOR; // : COLOR stands that color is a interpolated vertex color value
		};

		// inout keyword in cg/hlsl acts the same as ref in c#, which effectively becomes pass by reference 
		void surf(Input IN, inout SurfaceOutput o) {
			o.Albedo = 0.5; // simply sets the resulting color to gray 
		}
		ENDCG
	}
	FallBack "Diffuse"
}
