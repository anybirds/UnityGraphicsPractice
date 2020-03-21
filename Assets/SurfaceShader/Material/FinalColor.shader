Shader "Custom/FinalColor" {
    Properties {
        _MainTex ("Main Texture", 2D) = "white" {}
        _ColorTint ("Color Tint", Color) = (1.0, 1.0, 1.0, 1.0)
    }

    SubShader {
        Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
        CGPROGRAM
        #pragma surface surf Lambert finalcolor:tint

        struct Input {
            float2 uv_MainTex;
            float3 worldPos;
        };
        
        sampler2D _MainTex;
        fixed4 _ColorTint;

        void surf(in Input i, inout SurfaceOutput o) {
            o.Albedo = tex2D(_MainTex, i.uv_MainTex).rgb;
        }

        void tint(in Input i, in SurfaceOutput o, inout fixed4 color) {
            color *= _ColorTint;
        }

        ENDCG
    }

    FallBack "Diffuse"
}