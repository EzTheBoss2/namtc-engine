//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.	
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float time;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main()
{
    vec4 basecol = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
    if( basecol.r == 1. && basecol.b == 1. ) {
        basecol.rgb = vec3(step(0.25, rand(vec2(v_vTexcoord.x + time, v_vTexcoord.y + time))));
    } else {
        if( basecol.g == 1. && basecol.b == 1. ) {
            basecol.rgb = vec3(step(0.75, rand(vec2(v_vTexcoord.x + time, v_vTexcoord.y + time))));
        }
    }

    gl_FragColor = basecol;
}

