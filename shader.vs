attribute vec3 position;
attribute vec2 texCoord;
uniform mat4 vMat;
uniform mat4 pMat;
uniform float x;
uniform float y;
uniform float scale;
uniform float rotation;
uniform float texX;
uniform float texY;
uniform float alpha;
uniform float texScale;
varying vec2 vTextureCoord;
varying float vAlpha;

mat4 model(vec2 xy, float scale, float rot) {
    mat4 result = mat4(
        1.0, 0.0, 0.0, 0.0,
        0.0, 1.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        0.0, 0.0, 0.0, 1.0
    );
    result = result * mat4(
        1.0, 0.0, 0.0, 0.0,
        0.0, 1.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        xy.x, xy.y, 0.0, 1.0
    );
    result = result * mat4(
        scale, 0.0, 0.0, 0.0,
        0.0, scale, 0.0, 0.0,
        0.0, 0.0, scale, 0.0,
        0.0, 0.0, 0.0, 1.0
    );
    result = result * mat4(
        cos(radians(rot)), -sin(radians(rot)), 0.0, 0.0,
        sin(radians(rot)), cos(radians(rot)), 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        0.0, 0.0, 0.0, 1.0
    );
    return result;
}

void main(void) {
    vAlpha = alpha;
    vTextureCoord = (texCoord * texScale) + vec2(texX*64.0/512.0, texY*64.0/512.0);
    gl_Position = pMat * vMat * model(vec2(x, y), scale, rotation) * vec4(position, 1.0);
}
