Shader "Custom/CubemapReflection" {
    Properties {
        _MainTex ("Main Texture", 2D) = "white" {}
        _CubeMap ("Cube Map", CUBE) = "" {}
    }

    SubShader {
        Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
        
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input {
            float2 uv_MainTex;
            float3 worldRefl;
        };

        sampler2D _MainTex;
        samplerCUBE _CubeMap;

        void surf(in Input i, inout SurfaceOutput o) {
            o.Albedo = texCUBE(_CubeMap, i.worldRefl).rgb;
        }

        ENDCG
    }

    Fallback "Diffuse"
}