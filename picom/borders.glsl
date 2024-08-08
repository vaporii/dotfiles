#version 330

in vec2 texcoord;             // texture coordinate of the fragment
uniform sampler2D tex;        // texture of the window
uniform vec2 effective_size;  // effective dimensions of the texture
uniform float corner_radius;  // corner radius of the window (pixels)
uniform float border_width;   // estimated border width of the window (pixels)

// Function to check if the current fragment is within the border
bool is_border(vec2 pos, vec2 size, float radius, float border) {
    vec2 border_pos = pos / size;
    vec2 border_size = vec2(1.0) - border * 2.0 / size;

    if (border_pos.x < border / size.x || border_pos.x > 1.0 - border / size.x ||
        border_pos.y < border / size.y || border_pos.y > 1.0 - border / size.y) {
        return true;
    }

    vec2 dist = vec2(
        min(border_pos.x - border / size.x, 1.0 - border_pos.x - border / size.x),
        min(border_pos.y - border / size.y, 1.0 - border_pos.y - border / size.y)
    );
    
    if (dist.x < radius / size.x || dist.y < radius / size.y) {
        float corner_dist = length(dist - vec2(radius / size.x));
        return corner_dist < border / size.x;
    }

    return false;
}

// Default window post-processing:
// 1) invert color
// 2) opacity / transparency
// 3) max-brightness clamping
// 4) rounded corners
vec4 default_post_processing(vec4 c);

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);
    vec4 c = texture2D(tex, texcoord / texsize, 0);

    // If the current fragment is within the border, set the color to white
    if (is_border(texcoord, effective_size, corner_radius, border_width)) {
        c = vec4(1.0, 1.0, 1.0, 1.0);
    }

    return default_post_processing(c);
}

