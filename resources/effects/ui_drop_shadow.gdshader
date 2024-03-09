shader_type canvas_item;

const int MAX_BACKGROUND_COLORS = 4;
uniform vec4 background_colors[MAX_BACKGROUND_COLORS] : source_color;
uniform vec4 shadow_color : source_color;
uniform vec2 offset_in_pixels;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec4 current_color = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0);

    // Check if the current color is one of the background colors
    int found_background_color = 0;
    for (int i = 0; i < MAX_BACKGROUND_COLORS; i++) {
        if (length(current_color - background_colors[i]) < 0.01) {
            found_background_color = 1;
            break;
        }
    }

    if (found_background_color == 1) {
        // Calculate the offset for the shadow color
        vec2 offset = offset_in_pixels * SCREEN_PIXEL_SIZE;

        // Sample the shadow color at the offset position
        vec4 offset_color = textureLod(SCREEN_TEXTURE, SCREEN_UV - offset, 0.0);

        // Check if at our offset position we have a color which is not the background (meaning we need a shadow)
        int found_offset_color = 0;
        for (int i = 0; i < MAX_BACKGROUND_COLORS; i++) {
            if (length(offset_color - background_colors[i]) < 0.01) {
                found_offset_color = 1;
                break;
            }
        }

        if (found_offset_color == 0) {
            // If not, set it to our shadow color
            current_color = shadow_color;
        }
    }

    COLOR = current_color;
}