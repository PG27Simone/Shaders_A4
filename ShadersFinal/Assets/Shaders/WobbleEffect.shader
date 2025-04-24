Shader "Unlit/WobbleEffect"
{
    Properties
    {
        _Color ("Color Tint", Color) = (1, 0.06, 0, 1)
        _EmissionColor ("Emission Color", Color) = (1, 0.6, 0, 1)
        _Amplitude ("Amplitude", Range(0,0.5)) = 0.35
        _Speed ("Speed", Range(0,5)) = 2
        _NoiseStrength ("Noise Strength", Range(0,0.5)) = 0.2
        _Alpha ("Transparency", Range(0,1)) = 0.5
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
                float4 vertex : SV_POSITION;
            };

            float4 _Color;
            float4 _EmissionColor;
            float _Amplitude;
            float _Speed;
            float _NoiseStrength;
            float _Alpha;

            v2f vert(appdata v)
            {
                v2f o;

                float t = _Time.y * (_Speed/1000);

                // oscillates between 0 and _Amplitude
                float dynamicAmp = _Amplitude * (0.5 + 0.5 * sin(_Time.y)); 
                float pulse = sin(length(v.vertex.xyz) * 6.0 - _Time.y) * dynamicAmp;

                float n = frac(sin(dot(v.vertex.xyz * 3.0 + t, float3(10, 100, 10)))) * _NoiseStrength;
                float displacement = pulse + n;

                v.vertex.xyz += v.normal * displacement;

                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float3 finalColor = _Color.rgb + _EmissionColor.rgb;
                return float4(finalColor, _Alpha);
            }
            ENDCG
        }
    }
}
