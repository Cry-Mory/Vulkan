struct VertIn
{
    float3 pos    : POSITION;
    float2 uv     : TEXCOORD0;
    float3 normal : NORMAL0;
};

struct VertOut
{
    float4 pos       : SV_Position;
    float2 uv        : TEXCOORD0;
};

cbuffer CBUBO : register(b0, space0)
{
    float4x4 projection;
    float4x4 model;
    float4   viewPos;
    float    lodBias;
} ;

Texture2D<float4> sampleTexture : register(t1, space0);
SamplerState      sampleSampler : register(s2, space0);

struct FragOut
{
    float4 Color : SV_Target0;
};

VertOut TextureVS(VertIn IN)
{
    VertOut OUT = (VertOut)0;

    OUT.uv = IN.uv;

    float4 worldPos = mul(model, float4(IN.pos, 1.0));
    OUT.pos = mul(projection, worldPos);

    return OUT;
}

FragOut TexturePS(VertOut IN)
{
    float4 color = sampleTexture.Sample(sampleSampler, IN.uv);
    FragOut OUT = (FragOut)0;
    OUT.Color = float4(color.xyz, 1.0);
    return OUT;
}
