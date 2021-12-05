uniform float snap = 0.005;

vec4 effect( vec4 color, Image image, vec2 uvs, vec2 screen_coords )
{
    vec4 px = Texel(image,vec2(int(uvs.x/snap)*snap, int(uvs.y/snap)*snap));

    return px;
}