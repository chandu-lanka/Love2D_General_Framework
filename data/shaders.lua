-------- STORES ALL SHADERS AND THEIR CODE --------

SHADERS = {
EMPTY = love.graphics.newShader(
[[
vec4 effect( vec4 color, Image image, vec2 uvs, vec2 screen_coords )
{
    vec4 px = Texel(image,uvs);
    return px;
}
]]
),

GLOW = love.graphics.newShader(
[[
uniform float xRatio = 0;
int size = 6;
float multiplier = 0.005;
int unintensity = 0;
int iterations = size * size + unintensity;

vec4 effect( vec4 color, Image image, vec2 uvs, vec2 screen_coords )
{
    vec4 px = Texel(image,uvs);
    vec4 glow = px;

    for (int x = -size; x < size; x++) {
    for (int y = -size; y < size; y++) {

        float len = 1-sqrt(x*x+y*y)/size;

        glow += Texel(image,uvs + vec2(x * multiplier * xRatio, y * multiplier)) * len;

    }
    }

    return px + vec4(glow.r/iterations, glow.g/iterations, glow.b/iterations, 1);
}
]]
),

PIXEL_PERFECT = love.graphics.newShader(
[[
uniform float snap = 0.005;

vec4 effect( vec4 color, Image image, vec2 uvs, vec2 screen_coords )
{
    vec4 px = Texel(image,vec2(int(uvs.x/snap)*snap, int(uvs.y/snap)*snap));

    return px;
}
]]
),

FLASH = love.graphics.newShader(
[[
uniform float intensity = 0;

vec4 effect( vec4 color, Image image, vec2 uvs, vec2 screen_coords )
{
    vec4 px = Texel(image,uvs);
    px.r = px.r + (1 - px.r) * intensity;
    px.g = px.g + (1 - px.g) * intensity;
    px.b = px.b + (1 - px.b) * intensity;

    return px;
}
]]
),

LIGHT = love.graphics.newShader(
[[
#define NUM_LIGHTS 32

struct Light {
    vec2 position;
    vec3 diffuse;
    float power;
};

extern Light lights[NUM_LIGHTS];

extern vec2 screen;
extern int numLights;

extern float xRatio;

const float constant = 1.0;
const float linear = 0.09;
const float quadratic = 0.032;

vec4 effect( vec4 color, Image image, vec2 uvs, vec2 screen_coords )
{
    vec4 px = Texel(image,uvs);

    vec2 norm_screen_pos = screen_coords / screen;

    vec3 diffuse = vec3(0);

    for (int i = 0; i < numLights; i++) {
        Light light = lights[i];

        vec2 norm_pos = light.position / screen;

        float distance = length(vec2(norm_pos.x*xRatio,norm_pos.y) - vec2(norm_screen_pos.x*xRatio,norm_screen_pos.y)) * light.power;
        float attenuation = 1.0 / (constant + linear * distance + quadratic * (distance * distance));

        diffuse += light.diffuse * attenuation;
    }

    diffuse = clamp(diffuse,0.0,1.1);

    return px * vec4(diffuse, 1.0);
}
]]
)
}

SHADERS.GLOW:send("xRatio",aspectRatio[2])

lights = {}

function shine(x,y,diffuse,power)
    table.insert(lights,{position={x,y},diffuse=diffuse,power=power})
end

function processLights(position,diffuse,power)
    SHADERS.LIGHT:send("numLights",table.getn(lights))

    for id,L in pairs(lights) do
        actualId = id - 1
        SHADERS.LIGHT:send("lights["..tostring(actualId).."].position",L.position)
        SHADERS.LIGHT:send("lights["..tostring(actualId).."].diffuse",L.diffuse)
        SHADERS.LIGHT:send("lights["..tostring(actualId).."].power",L.power)
    end
end

function resetLights()
    lights = {}
end


postPro = SHADERS.EMPTY