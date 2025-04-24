Shader "Unlit/ThermalShader"
{
    Properties
    {
        _HeatColor1 ("Coolest", Color) = (0, 0, 1, 1)
        _HeatColor2 ("Cool", Color) = (0, 1, 0, 1)
        _HeatColor3 ("Hot", Color) = (1, 1, 0, 1)
        _HeatColor4 ("Hottest", Color) = (1, 0, 0, 1)
        _HeatColor5 ("Overheat", Color) = (1, 1, 1, 1)
        _Speed ("Heat Flicker Speed", Range(0,5)) = 2
        _FlickerAmount ("Flicker Amount", Range(0, 0.2)) = 0.02
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

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldNormal : TEXCOORD0;
            };

            float4 _HeatColor1, _HeatColor2, _HeatColor3, _HeatColor4, _HeatColor5;
            float _Speed;
            float _FlickerAmount;

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldNormal = normalize(mul(v.normal, (float3x3)unity_ObjectToWorld));
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
                 //light intensity
                float heat = saturate(dot(i.worldNormal, lightDir)); 

                float flicker = sin(_Time.y * _Speed + heat * 10.0) * _FlickerAmount;
                heat = saturate(heat + flicker);

                //change color based on angle compared to directional light
                float3 color;
                if (heat < 0.25){
                    color = lerp(_HeatColor1.rgb, _HeatColor2.rgb, heat) * 2;
                }
                else if (heat < 0.5){
                    color = lerp(_HeatColor2.rgb, _HeatColor3.rgb, (heat - 0.25)* 2);
                }
                else if (heat < 0.75){
                    color = lerp(_HeatColor3.rgb, _HeatColor4.rgb, (heat - 0.5)* 2);
                }
                else{
                    color = lerp(_HeatColor4.rgb, _HeatColor5.rgb, (heat - 0.75)* 2);
                 }

                return float4(color, 1);
            }
            ENDCG
        }
    }
}
