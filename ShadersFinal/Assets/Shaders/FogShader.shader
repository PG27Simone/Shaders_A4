Shader "Unlit/FogShader"
{
    Properties
    {
        _FogColor ("Fog Color", Color) = (0.7, 0.8, 1, 1)
        _EdgeFade ("Edge Fade", Range(0.0, 5.0)) = 1.5
        _Alpha ("Alpha", Range(0.0, 1.0)) = 0.4
        _Speed ("Speed", Range(0.0, 5.0)) = 0.5
        _Distortion ("Distortion", Range(0.0, 1.0)) = 0.3
    }

    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldPos : TEXCOORD0;
                float3 localPos : TEXCOORD1;
            };

            float4 _FogColor;
            float _EdgeFade;
            float _Alpha;
            float _Speed;
            float _Distortion;

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.localPos = v.vertex.xyz;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float3 pos = i.localPos;

                float drift = sin(pos.x * 1.5 + _Time.y * _Speed) * _Distortion;
                drift += cos(pos.z * 1.2 + _Time.y * _Speed * 1.3) * _Distortion;

                float dist = length(pos + drift);
                float fade = saturate(1.0 - dist * _EdgeFade);

                return float4(_FogColor.rgb, fade * _Alpha);
            }
            ENDCG
        }
    }
}
