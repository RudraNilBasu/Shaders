// Upgrade NOTE: commented out 'float4x4 _Object2World', a built-in variable
// Upgrade NOTE: commented out 'float4x4 _World2Object', a built-in variable

shader "Rudra/begin/2 - Lambert" {
	Properties{
		_Color("Color", Color) = (1.0,1.0,1.0,1.0)
	}
		SubShader{
			Pass {
				Tags{"LightMode" = "ForwardBase"}

				// stop programming in shaderlabs and start programming in CG
				CGPROGRAM
	#pragma vertex vert
	#pragma fragment frag

				// user defined variables
				uniform float4 _Color;
				

				// Unity defined variables
				uniform float4 _LightColor0; // the color of the light

				// Unity3.x or less definitions
				// float4x4 _Object2World;
				// float4x4 _World2Object;
				//float4 _WorldSpaceLightPos0;

				// base input structs
				struct vertexInput {

					float4 vertex: POSITION;
					float3 normal: NORMAL;
				};

				struct vertexOutput {
					float4 pos: SV_POSITION;
					float4 col: COLOR; // contains vertex color, will override the vertex color with our own color
				};

				// vertex function
				vertexOutput vert(vertexInput v) {
					vertexOutput o;

					float3 normalDirection = normalize(mul( float4(v.normal, 0.0 ), _World2Object ).xyz);
					// calculating light
					float3 lightDirection;
					float atten = 1.0;

					// calculate light direction
					lightDirection = normalize( _WorldSpaceLightPos0.xyz );
					float3 diffuseReflection = atten * _LightColor0.xyz * _Color.rgb * max(0.0, dot(normalDirection, lightDirection));
					// BUG - Lighting not changing with changing the color / rotation of light source

					o.col = float4(diffuseReflection, 1.0);
					o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
					return o;
				}

				// fragment function
				float4 frag(vertexOutput i) : COLOR
				{
					return i.col;
				}
			ENDCG
		}
	}
	Fallback "Diffuse"
}
