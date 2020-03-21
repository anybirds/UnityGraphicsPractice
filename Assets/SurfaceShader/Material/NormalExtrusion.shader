Shader "Custom/NormalExtrusion" {
    Properties {
        _MainTex ("Main Texture", 2D) = "white" {}
        _Amount ("Extrusion Amount", Range(-1, 1)) = 0.0
    }
    
    SubShader {
        Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }

        CGPROGRAM
        #pragma surface surf Lambert vertex:vert addshadow
        
        struct Input {
            float2 uv_MainTex;
        };

        sampler2D _MainTex;
        float _Amount;

        void vert(inout appdata_full v) {
            v.vertex.xyz += v.normal * _Amount;
        }

        void surf(in Input i, inout SurfaceOutput o) {
            o.Albedo = tex2D(_MainTex, i.uv_MainTex).rgb;
        }

        ENDCG
    }

    Fallback "Diffuse"
}