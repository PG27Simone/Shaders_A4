Shader "Unlit/TreeWind"
{
    Properties
    {
        _Color ("Color", Color) = (0.2, 0.6, 0.3, 1)
        _Amplitude ("Amplitude", Range(0, 0.5)) = 0.1
        _Speed ("Speed", Range(0, 5)) = 1
        _Alpha ("Alpha", Range(0,1)) = 0.6
    }

    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        LOD 100
        Cull Back
        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
            };

            float4 _Color;
            float _Amplitude;
            float _Speed;
            float _Alpha;

            v2f vert(appdata v)
            {
                float t = _Time.y * (_Speed/1000);

                float n = frac(sin(dot(v.vertex.xyz * 10.0 + t, float3(10, 100, 10)))) * 0.2;

                v.vertex.xyz += v.normal * n;

                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return float4(_Color.rgb, _Alpha);
            }
            ENDCG
        }
    }
}
