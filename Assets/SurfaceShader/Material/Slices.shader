Shader "Custom/Slices" {
    Properties {
        _MainTex ("Main Texture", 2D) = "white" {}
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _Offset("Slice Offset", Range(0.0, 1.0)) = 0.0 
    }

    SubShader {
        Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
        Cull Off

        CGPROGRAM
        #pragma surface surf Lambert addshadow

        struct Input {
            float2 uv_MainTex;
            float2 uv_NormalMap;  
            float3 worldPos;
        };

        sampler2D _MainTex;
        sampler2D _NormalMap;
        float _Offset;
        
        void surf(in Input i, inout SurfaceOutput o) {
            clip(frac((i.worldPos.y + _Offset) * 5) - 0.5);
            o.Albedo = tex2D(_MainTex, i.uv_MainTex).rgb;
            o.Normal = UnpackNormal(tex2D(_NormalMap, i.uv_NormalMap));
        }
        ENDCG
    }

    Fallback "Diffuse"
}