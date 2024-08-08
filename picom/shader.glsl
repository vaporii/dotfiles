#version 330
in vec2 texcoord;             // texture coordinate of the fragment

uniform vec2 effective_size;
uniform sampler2D tex;        // texture of the window
// Default window post-processing:
// 1) invert color
// 2) opacity / transparency
// 3) max-brightness clamping
// 4) rounded corners
vec4 default_post_processing(vec4 c);
// Default window shader:
// 1) fetch the specified pixel
// 2) apply default post-processing

// float roundedFrame(vec2 pos, vec2 size, float radius, float thickness, vec2 texcoord)
// {
//     vec2 uv = (2.0 * texcoord - 1.0) * effective_size;
//     float d = length(max(abs(uv - pos), size) - size) - radius;
//     return smoothstep(0.55, 0.45, abs(d / thickness) * 5.0);
// }

float roundedFrame (vec2 pos, vec2 size, float radius, float thickness)
{
    vec2 uv = texcoord;
    // vec2 uv = texcoord / texsize;
    float d = length(max(abs(uv - pos),size) - size) - radius;
    return smoothstep(0.0, 0.7, smoothstep(1, 0, abs(d / thickness)));
    // return (d / thickness);
    // return smoothstep(1, 0, abs(d / thickness) * 1.0); // anti aliasing?
}

float rectangle(vec2 pos, vec2 size) {
    vec2 texsize = textureSize(tex, 0);
    vec2 uv = texcoord / texsize;
    size *= 0.5;
    vec2 r = abs(uv - pos - size) - size;
    return step(max(r.x, r.y), 0.0);
    // return 1.0;
}

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);
    vec2 coord = texcoord / texsize;

    vec4 c = texture2D(tex, coord, 0);

    if (texsize.x < 1920 || texsize.y < 1080) {
        float radiusidk = 8.0;
        float offset = 10.0;
        float frame = roundedFrame(texsize / 2.0, vec2(texsize.x / 2 - offset, texsize.y / 2 - offset), 10.0, 1.0);

        // c += vec4(0.0, 1.0, 0.0, 1.0) * frame;
        c += vec4(0.705882352941, 0.745098039216, 0.996078431373, 1.0) * frame;
        // c.b += 0.2;
    }


    return default_post_processing(c);
}
