Shader "Custom/NormalMapping" {
    Properties { 
        _MainTex ( "Main Texture", 2D ) = "white" {}
        _NormalMap ( "Normal Map", 2D ) = "bump" {}
    }

    SubShader {
        Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
        CGPROGRAM
        #pragma surface surf Lambert
        struct Input {
            float2 uv_MainTex;
            float2 uv_NormalMap;  
        };
        sampler2D _MainTex;
        sampler2D _NormalMap;
        void surf(in Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
            o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
        }
        ENDCG
    }
    Fallback "Diffuse"
}