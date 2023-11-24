#version 460 core

uniform vec2 resolution;
uniform float time;
uniform vec3 cameraPos;
uniform float externTorusRot;

precision highp float;

out vec4 outcolor;

const int NUMBER_OF_STEPS = 128;
const float MINIMUM_HIT_DISTANCE = 0.001;
const float MAXIMUM_TRACE_DISTANCE = 64.0;

// other wack math stuff
mat4 rotationMatrix(vec3 axis, float angle)
{
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;
    
    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
                oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
                oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
                0.0,                                0.0,                                0.0,                                1.0);
}

float opSmoothUnion( float d1, float d2, float k )
{
    float h = clamp( 0.5 + 0.5*(d2-d1)/k, 0.0, 1.0 );
    return mix( d2, d1, h ) - k*h*(1.0-h);
}

// SDFS
float sdfSphere(vec3 p, vec3 c, float r) {
    return length(p - c) - r;
}

float sdfTorus( vec3 p, vec2 t , mat4 transform)
{
    p = (vec4(p, 1.0) * transform).xyz; 
    vec2 q = vec2(length(p.xz)-t.x,p.y);
    return length(q)-t.y;
}

float sdfPlane(vec3 p, vec3 n, float h) {
    return dot(p, n) + h;
}

// render stuff

float map(vec3 currentPos) {

    // Define the tile size along the x and z axes
    float tileSizeX = 0.0; // This will repeat the space every 5 units along x
    float tileSizeZ = 0.0; // This will repeat the space every 7 units along z

    // Calculate the adjusted coordinates for tiling
    float adjustedX = mod(currentPos.x, tileSizeX);
    float adjustedZ = mod(currentPos.z, tileSizeZ);
    
    vec3 newpos = vec3(adjustedX, currentPos.y, adjustedZ);

    float radius = 0.5;
    vec3 center = vec3(0.0);

    float sphere = sdfSphere(newpos, center, radius);

    float m = sphere;

    float h = 1.0;
    vec3 normal = vec3(0.0, 1.0, 0.0);
    float plane = sdfPlane(newpos, normal, h);

    float torus = sdfTorus(newpos, vec2(1,0.1), rotationMatrix(vec3(0.892, 0.734, 0.41), time * 1.5 + externTorusRot));

    // Apply smooth union to combine the shapes
    m = opSmoothUnion(torus, plane, 0.8);
    m = min(m, sphere);

    return m;
}

vec3 getNormal(vec3 p) {
    vec2 d = vec2(0.1, 0.0);

    float gx = map(p + d.xyy) - map(p - d.xyy);
    float gy = map(p + d.yxy) - map(p - d.yxy);
    float gz = map(p + d.yyx) - map(p - d.yyx);

    vec3 normal = vec3(gx, gy, gz);
    return normalize(normal);
}

float raymarch(vec3 ro, vec3 rd, float maxDistance) {
    // distance traveled
    float dt = 0.0;

    for(int i = 0; i < NUMBER_OF_STEPS; i++) {
        vec3 currentPos = ro + rd * dt;
        float distToSdf = map(currentPos);

        if(distToSdf < MINIMUM_HIT_DISTANCE) {
            break;
        }

        dt += distToSdf;

        if(dt > maxDistance) {
            break;
        }
    }

    return dt;
}

vec3 render(vec2 uv) {
    vec3 color = vec3(0.0);

    vec3 ro = cameraPos;
    vec3 rd = vec3(uv, 1.0);

    float dist = raymarch(ro, rd, MAXIMUM_TRACE_DISTANCE);
    
    if(dist < MAXIMUM_TRACE_DISTANCE) {
        color = vec3(1.0);
        
        // calculate normal at exact point where we hit sdf
        vec3 hitpos = ro + rd * dist;
        vec3 normal = getNormal(hitpos);
        color = normal;
        
        // lighting stuff
        vec3 ambient = vec3(0.1);

        vec3 lightColor = vec3(1.0);
        vec3 lightSource = vec3(2.5, 2.5, -1.0);

        float diffuseStrength = max(0.0, dot(normalize(lightSource), normal));
        vec3 diffuse = lightColor * diffuseStrength;

        vec3 viewSource = normalize(ro);
        vec3 reflectSource = normalize(reflect(-lightSource, normal));

        float specularStrength = max(0.0, dot(viewSource, reflectSource));
        specularStrength = pow(specularStrength, 64.0);
        vec3 specular = specularStrength * lightColor;

        vec3 lighting = diffuse * 0.75 + specular * 0.25;

        color = lighting;

        // shadows (raymarching from the hit point back to the light source)
        vec3 lightDirection = normalize(lightSource);
        float distToLightSource = length(lightSource - hitpos);
        ro = hitpos + normal * 0.1;
        rd = lightDirection;

        float dist = raymarch(ro, rd, distToLightSource);
        if (dist < distToLightSource) {
            color = color * vec3(0.25);
        }

        // gamma correction
        color = pow(color, vec3(1.0 / 2.2));
    }

    return color;
}

void main() {
   vec2 uv = (gl_FragCoord.xy / resolution.xy) * 2.0 - 1.0;

    // Adjust for aspect ratio
    float aspectRatio = resolution.x / resolution.y;
    uv.x *= aspectRatio;

    // for some reason y coordinates are inverted in flutter
    uv.y = -uv.y;

    vec3 color = vec3(0.0);

    color = render(uv);

    outcolor = vec4(color, 0);
}