Shader "Unlit/Mushroom"
{
    Properties
    {
        _Color ("Base Color", Color) = (0.5, 1.0, 0.6, 1)
        _EmissionColor ("Emission Color", Color) = (0.3, 1.0, 0.5, 1)
        _GlowSpeed ("Glow Speed", Range(0, 10)) = 2
        _GlowStrength ("Glow Strength", Range(0, 5)) = 2
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            float4 _Color;
            float4 _EmissionColor;
            float _GlowSpeed;
            float _GlowStrength;

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float pulse = (sin(_Time.y * _GlowSpeed) + 1.0) * 0.5;
                float3 glow = _EmissionColor.rgb * (pulse * _GlowStrength);
                return float4(_Color.rgb + glow, 1);
            }
            ENDCG
        }
    }
}
