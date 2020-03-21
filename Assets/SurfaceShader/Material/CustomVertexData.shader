Shader "Custom/CustomVertexData" {
    Properties {
        _MainTex ("Main Texture", 2D) = "white" {}
    }

    SubShader {
        Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
        
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert
        
        struct Input {
            float2 uv_MainTex;
            float3 customColor;
        };

        sampler2D _MainTex;
        
        void vert(inout appdata_full v, out Input o) {
            UNITY_INITIALIZE_OUTPUT(Input, o);
            o.customColor = abs(v.normal);
        }

        void surf(in Input i, inout SurfaceOutput o) {
            o.Albedo = tex2D(_MainTex, i.uv_MainTex).rgb;
            o.Albedo *= i.customColor;
        }

        ENDCG
    }

    FallBack "Diffuse"
}