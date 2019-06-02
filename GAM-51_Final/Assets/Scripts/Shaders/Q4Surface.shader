Shader "Custom/Q4Surface"
{
	Properties
	{
		_FirstTex("First Texture", 2D) = "white" {}
		_SecondTex("Second Texture", 2D) = "white" {}
		_ThirdTex("Third Texture", 2D) = "white" {}
		_FirstTexSpeed("First Texture Speed", vector) = (0,0,0,0)
		_SecondTexSpeed("Second Texture Speed", vector) = (0,0,0,0)
		_ThirdTexSpeed("Third Texture Speed", vector) = (0,0,0,0)
	}

	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard

		struct Input
		{
			float2 uv_FirstTex;
			float2 uv_SecondTex;
			float2 uv_ThirdTex;
		};

		sampler2D _FirstTex;
		sampler2D _SecondTex;
		sampler2D _ThirdTex;
		float4 _FirstTexSpeed;
		float4 _SecondTexSpeed;
		float4 _ThirdTexSpeed;

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			IN.uv_FirstTex += _Time * _FirstTexSpeed;
			IN.uv_SecondTex += _Time * _SecondTexSpeed;
			IN.uv_ThirdTex += _Time * _ThirdTexSpeed;
			float4 texOne = tex2D(_FirstTex, IN.uv_FirstTex);
			float4 texTwo = tex2D(_SecondTex, IN.uv_SecondTex);
			float4 texThree = tex2D(_ThirdTex, IN.uv_ThirdTex);

			float4 result;
			result.r = texOne.r / 3 + texTwo.r / 3 + texThree.r / 3;
			result.g = texOne.g / 3 + texTwo.g / 3 + texThree.g / 3;
			result.b = texOne.b / 3 + texTwo.b / 3 + texThree.b / 3;

			o.Albedo = result;
		}

	ENDCG
	}
	Fallback "Diffuse"
}