Shader "Custom/Q5Surface"
{
	Properties
	{
		_FirstTex("First Texture", 2D) = "white" {}
		_FirstBump("First Normal", 2D) = "bump" {}
		_SecondTex("Second Texture", 2D) = "white" {}
		_SecondBump("Second Normal", 2D) = "bump" {}
		_ThirdTex("Third Texture", 2D) = "white" {}
		_ThirdBump("Third Normal", 2D) = "bump" {}
		_FirstTexSpeed("First Texture Speed", vector) = (0,0,0,0)
		_SecondTexSpeed("Second Texture Speed", vector) = (0,0,0,0)
		_ThirdTexSpeed("Third Texture Speed", vector) = (0,0,0,0)
	}

		SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard
		#pragma target 3.0

		struct Input
		{
			float2 uv_FirstTex;
			float2 uv_FirstBump;
			float2 uv_SecondTex;
			float2 uv_SecondBump;
			float2 uv_ThirdTex;
			float2 uv_ThirdBump;
		};

		sampler2D _FirstTex;
		sampler2D _FirstBump;
		sampler2D _SecondTex;
		sampler2D _SecondBump;
		sampler2D _ThirdTex;
		sampler2D _ThirdBump;
		float4 _FirstTexSpeed;
		float4 _SecondTexSpeed;
		float4 _ThirdTexSpeed;

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			IN.uv_FirstTex += _Time * _FirstTexSpeed;
			IN.uv_FirstBump += _Time * _FirstTexSpeed;
			IN.uv_SecondTex += _Time * _SecondTexSpeed;
			IN.uv_SecondBump += _Time * _SecondTexSpeed;
			IN.uv_ThirdTex += _Time * _ThirdTexSpeed;
			IN.uv_ThirdBump += _Time * _ThirdTexSpeed;

			float3 texOne = tex2D(_FirstTex, IN.uv_FirstTex).rgb;
			float3 texTwo = tex2D(_SecondTex, IN.uv_SecondTex).rgb;
			float3 texThree = tex2D(_ThirdTex, IN.uv_ThirdTex).rgb;

			float3 bumpOne = UnpackNormal(tex2D(_FirstBump, IN.uv_FirstBump));
			float3 bumpTwo = UnpackNormal(tex2D(_SecondBump, IN.uv_SecondBump));
			float3 bumpThree = UnpackNormal(tex2D(_ThirdBump, IN.uv_ThirdBump));

			float4 result;
			result.r = texOne.r / 3 + texTwo.r / 3 + texThree.r / 3;
			result.g = texOne.g / 3 + texTwo.g / 3 + texThree.g / 3;
			result.b = texOne.b / 3 + texTwo.b / 3 + texThree.b / 3;

			float4 bumpResult;
			bumpResult.r = bumpOne.r / 3 + bumpTwo.r / 3 + bumpThree.r / 3;
			bumpResult.g = bumpOne.g / 3 + bumpTwo.g / 3 + bumpThree.g / 3;
			bumpResult.b = bumpOne.b / 3 + bumpTwo.b / 3 + bumpThree.b / 3;

			o.Albedo = result;
			o.Normal = bumpResult;
		}

	ENDCG
	}
	Fallback "Diffuse"
}