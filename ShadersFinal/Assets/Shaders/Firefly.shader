Shader "Unlit/Firefly"
{
    Properties
    {
        _Color ("Glow Color", Color) = (1, 1, 0.5, 1)
        _Amplitude ("Bounce Height", Range(0, 1)) = 0.2
        _Speed ("Bounce Speed", Range(0, 10)) = 2
        _Size ("Size", Float) = 0.05
        _Alpha ("Alpha", Range(0,1)) = 1
    }

    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        LOD 100
        Cull Off
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
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
            };

            float4 _Color;
            float _Amplitude;
            float _Speed;
            float _Alpha;
            float _Size;

            v2f vert(appdata v)
            {
                v2f o;

                float wave = sin(_Time.y * _Speed + v.vertex.x * 2.0);
                v.vertex.y += wave * _Amplitude;
                v.vertex.xyz *= _Size;

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
