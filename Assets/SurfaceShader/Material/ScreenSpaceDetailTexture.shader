Shader "Custom/ScreenSpaceDetailTexture" {
	Properties{
		_MainTex ("Main Texutre", 2D) = "white" {}
		_NormalMap ("Normal Map", 2D) = "bump" {}
		_DetailTex ("Detail Texture", 2D) = "black" {}
	}

	SubShader {
		Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
		
		CGPROGRAM
		#pragma surface surf Lambert
		
		struct Input {
			float2 uv_MainTex;
			float2 uv_NormalMap;
			float4 screenPos;
		};

		sampler2D _MainTex;
		sampler2D _NormalMap;
		sampler2D _DetailTex;

		void surf(in Input i, inout SurfaceOutput o) {
			o.Albedo = tex2D(_MainTex, i.uv_MainTex).rgb;
			o.Normal = UnpackNormal(tex2D(_NormalMap, i.uv_NormalMap));
			float2 uv_detail = i.screenPos.xy / i.screenPos.w;
			uv_detail.x *= _ScreenParams.x / _ScreenParams.y;
			float3 detail = saturate(tex2D(_DetailTex, uv_detail).rgb + 0.5);
			o.Albedo *= detail; 
		}
		
		ENDCG
	}

	FallBack "Diffuse"
}