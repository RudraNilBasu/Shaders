shader "Rudra/begin/1 - Flat Color" {

	Properties{
		_Color("Color", Color) = (1.0, 1.0, 1.0, 1.0)
	}
		SubShader{
		Pass {
			CGPROGRAM
			// pragmas
#pragma vertex vert
#pragma fragment frag
		// assigning which function is the vertex function
		// and which one is the fragment function


			// user defined variables
			uniform float4 _Color;
				// base input structs
			struct vertexInput {
				float4 vertex: POSITION;
			};
			struct vertexOutput {
				float4 pos: SV_POSITION; // convert the vertex position from 
				// the input and convert it into the output
				// unity will take the vertex position from the output "pos"
			};
				// vertex functions
			vertexOutput vert(vertexInput v) {
				vertexOutput o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex); // moving vertex position from 
				// the object to the unity matrix position

				// UNITY_MATRIX_MVP = x,y,z,w coordinate
				// v.vertex => x,y,z,w coordinates
				return o;
			}
				// fragment functions
			float4 frag(vertexOutput i) : COLOR
			{
				return _Color;
			}
			ENDCG
		}
	}
		// fallback => Runs when the shader doesn't 
				// run due to any error
				// in this case if we come across any error
				// in the shader, then it will automatically 
				// switch  to diffuse
		fallback "Diffuse"
}
