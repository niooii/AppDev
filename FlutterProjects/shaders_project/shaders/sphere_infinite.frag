#version 330 core
    
uniform vec2 resolution;
uniform float time;
uniform vec3 cameraPos;
uniform vec3 rot;

out vec4 outcolor;

const int STEPS = 128;
const float HIT_DISTANCE = 0.001;
const float MAX_DISTANCE = 256;
const float REPEAT_FACTOR = 2.0;

mat4 rotationFromAxis(vec3 axis, float angle) {
    axis = normalize(axis);
    float s = sin(angle), c = cos(angle), oc = 1.0 - c;
    return mat4(oc * axis.x * axis.x + c, oc * axis.x * axis.y - axis.z * s, oc * axis.z * axis.x + axis.y * s, 0.0,
                oc * axis.x * axis.y + axis.z * s, oc * axis.y * axis.y + c, oc * axis.y * axis.z - axis.x * s, 0.0,
                oc * axis.z * axis.x - axis.y * s, oc * axis.y * axis.z + axis.x * s, oc * axis.z * axis.z + c, 0.0,
                0.0, 0.0, 0.0, 1.0);
}

// don ask why this is a mat3
mat3 rotation(float roll, float pitch, float yaw)
{
    float sinRoll = sin(roll);
    float cosRoll = cos(roll);
    float sinPitch = sin(pitch);
    float cosPitch = cos(pitch);
    float sinYaw = sin(yaw);
    float cosYaw = cos(yaw);
      
    return mat3(
        vec3(cosRoll * cosPitch, cosRoll * sinPitch * sinYaw - sinRoll * cosYaw, cosRoll * sinPitch * cosYaw + sinRoll * sinYaw),
        vec3(sinRoll * cosPitch, sinRoll * sinPitch * sinYaw + cosRoll * cosYaw, sinRoll * sinPitch * cosYaw - cosRoll * sinYaw),
        vec3(-sinPitch, cosPitch * sinYaw, cosPitch * cosYaw));
}

float sdfSphere(vec3 p, vec3 c, float r) {
    return length(mod(p, 2.0) - c) - r;
}

float sdfTorus(vec3 p, vec2 t, mat4 transform) {
    p = (vec4(p, 1.0) * transform).xyz; 
    vec2 q = vec2(length(p.xz) - t.x, p.y);
    return length(q) - t.y;
}

float map(vec3 currentPos) {

    float sphere = sdfSphere(currentPos, vec3(0.5), 0.1);
    // float plane = sdfPlane(newpos, vec3(0.0, 1.0, 0.0), 1.0);
    float torus = sdfTorus(currentPos - 0.5, vec2(0.15, 0.02), rotationFromAxis(vec3(1, 0.7, 0.4), time * 1.5));

    float m = min(sphere, torus);

    return m;
}

vec3 getNormal(vec3 p) {
    vec2 d = vec2(0.1, 0.0);
    vec3 n = vec3(map(p + d.xyy) - map(p - d.xyy),
                  map(p + d.yxy) - map(p - d.yxy),
                  map(p + d.yyx) - map(p - d.yyx));
    return normalize(n);
}

float phong(vec3 surfacePoint, vec3 normal, vec3 lightPosition, vec3 viewerDirection, float ambient, float diffuse, float specular, float shininess)
{
    vec3 lightDirection = normalize(lightPosition - surfacePoint);
    
    vec3 reflection = normalize(2.0 * dot(lightDirection, normal) * normal - lightDirection);
    return ambient + diffuse * clamp(dot(lightDirection, normal), 0.0, 1.0) + specular * pow(clamp(dot(reflection, viewerDirection), 0.0, 1.0), shininess);
}

float shade(vec3 position, vec3 lightPosition, vec3 cameraPosition, float ambient, float diffuse, float specular, float shininess)
{
    vec3 normal = getNormal(position);
    vec3 lightDir = normalize(lightPosition - position);
    vec3 pointToCamera = normalize(cameraPosition - position);

    float brightness = phong(position, normal, lightPosition, pointToCamera, ambient, diffuse, specular, shininess);
    clamp(dot(lightDir, normal), 0.0, 1.0);
    
    float distance = length(position - cameraPosition);
    
    // Apply fog.
    brightness /= max(distance - 3.0, 0.001);
    
    return brightness;
}

vec3 wrapSpace(vec3 p)
{
    return mod(p, REPEAT_FACTOR);
}

// space wrapping stuff i forgot
// how this works already
// nvm
// DISTANCE FROM NEXT UNIT CUBE
// BOUNDARY
float unitSpaceDistance(vec3 position, vec3 rayDirection)
{
    float dx, dy, dz;
    
    if (rayDirection.x < 0.0)
        dx = position.x;
    else
        dx = REPEAT_FACTOR - position.x;
        
    if (rayDirection.y < 0.0)
        dy = position.y;
    else
        dy = REPEAT_FACTOR - position.y;
        
    if (rayDirection.z < 0.0)
        dz = position.z;
    else
        dz = REPEAT_FACTOR - position.z;
        
    return min(min(dx, dy), dz);        
}

float rayMarchUnit(vec3 ro, vec3 rd)
{
    float distFromOrigin = 0.0;
    float totalDistance = 0.0;
    ro = wrapSpace(ro);
    
    for (int i = 0; i < STEPS; ++i)
    {
        // cp current pos
        vec3 cp = ro + distFromOrigin * rd;
        float distToSdf = map(cp);
        // unit space dist
        float usdist = unitSpaceDistance(cp, rd);
        
        if (usdist < distToSdf)
        {
            distFromOrigin += usdist;
            totalDistance += usdist;
            
            if (usdist < HIT_DISTANCE || totalDistance > MAX_DISTANCE)
            {
                // make sure space wraps around properly
                ro = wrapSpace(ro + rd * (distFromOrigin + HIT_DISTANCE));
                distFromOrigin = 0.0;
            }
        }
        else
        {
            distFromOrigin += distToSdf;
            totalDistance += distToSdf;

            if (distToSdf < HIT_DISTANCE || totalDistance > MAX_DISTANCE)
                return min(MAX_DISTANCE, totalDistance);
        }
    }
    
    return MAX_DISTANCE;
}

vec3 render(vec2 uv) {
    // start off with white
    vec3 col = vec3(0.0);
    vec3 ro = cameraPos;
    vec3 rd = vec3(uv, 1.0) * rotation(rot.x, rot.y, rot.z);
    float dist = rayMarchUnit(ro, rd);
    if (dist < MAX_DISTANCE) {
        vec3 hitpos = ro + rd * dist;
        vec3 lightSource = vec3(2.5, 2.5, -1.0);
        col = vec3(shade(hitpos, lightSource, cameraPos, 1.0, 0.0, 0.0, 10.0));
    }
    return col;
}

void main() {
    vec2 uv = (gl_FragCoord.xy - resolution.xy / 2.0) / resolution.y;
    vec3 color = render(uv);
    outcolor = vec4(color, 1.0);
}
