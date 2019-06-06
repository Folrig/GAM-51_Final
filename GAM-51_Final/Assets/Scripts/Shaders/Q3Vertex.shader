 Shader "Unlit/Q3Vertex"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_TranslationAmount("Translation Amount", Range(0,20)) = 1.0
		_MaxDistance("Maximum Distance", float) = 25.0
		_TargetPointX("Target X Pos", float) = 0.0
		_TargetPointY("Target Y Pos", float) = 0.0
		_TargetPointZ("Target Z Pos", float) = 0.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert
		struct Input {
		float2 uv_MainTex;
	};
	
	float _TranslationAmount;
	float _MaxDistance;
	float _TargetPointX;
	float _TargetPointY;
	float _TargetPointZ;

	void vert(inout appdata_full v)
	{
		// Get vertex distance from our target
		float3 targetPoint = float3(_TargetPointX, _TargetPointY, _TargetPointZ);
		float3 vertWorldPos = mul(unity_ObjectToWorld, v.vertex);
		float totalDistance = distance(targetPoint, vertWorldPos);

		// If vertex is farther than maximum distance, render normally
		if (totalDistance >= _MaxDistance)
		{
			totalDistance = 0;
		}

		// If within maximum distance, translate the vertex along its normal based on distance
		float distancePercent = 1.0 - (totalDistance / _MaxDistance);
		float translationAmount = _TranslationAmount;
		translationAmount *= distancePercent;
		v.vertex.xyz += v.normal * translationAmount;
	}

	sampler2D _MainTex;

	void surf(Input IN, inout SurfaceOutput o)
	{
		o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
	}
		ENDCG
	}
	Fallback "Diffuse"
}