Shader "Custom/RimLighting" {
    Properties {
        _MainTex ("Main Texture", 2D) = "white" {}
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _RimColor ("Rim Color", Color) = (0.26, 0.19, 0.16, 0)
        _RimPower ("Rim Power", Range(0.5, 8.0)) = 3.0
    }

    SubShader {
        Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }

        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input {
            float2 uv_MainTex;
            float2 uv_NormalMap;
            float3 viewDir;  
        };
        
        sampler2D _MainTex;
        sampler2D _NormalMap;
		float4 _RimColor;
		float _RimPower;

        void surf(in Input i, inout SurfaceOutput o) {
            o.Albedo = tex2D(_MainTex, i.uv_MainTex);
            o.Normal = UnpackNormal(tex2D(_NormalMap, i.uv_NormalMap));
            // use tangent space noraml to calculate the effect of rim light
            half rim = 1 - saturate(dot(normalize(i.viewDir), o.Normal));
            // control emission, instead of adding to albedo 
            o.Emission = _RimColor * pow(rim, _RimPower);
        }
        ENDCG
    }

    FallBack "Diffuse"
}