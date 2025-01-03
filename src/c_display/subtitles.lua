---@type NineSlice
local background_center = {
    left = 7,
    right = 7,
    top = 7,
    bottom = 7
}
local background_texture = get_texture_info("subtitle_bg")

local gActiveSubtitles = gActiveSubtitles
local function on_hud_render()
    djui_hud_set_resolution(RESOLUTION_DJUI)

    local screen_width = djui_hud_get_screen_width()
    local center_x = screen_width / 2

    local screen_height = djui_hud_get_screen_height()
    local y = screen_height - 128

    local text_scale = 1

    djui_hud_set_font(djui_menu_get_font())

    for i, subtitle in next, gActiveSubtitles do
        y = y - 48
        local width = math.floor((djui_hud_measure_text(subtitle.text) * text_scale) + 0.5)
        local x = math.floor((screen_width - width) / 2)
        djui_hud_set_color(0, 0, 0, 200)
        -- render_nine_slice(background_texture, x - 8, y - 4, width + 16, 44, background_center, text_scale)
        djui_hud_render_rect(x - 8, y - 4, width + 16, 44)
        djui_hud_set_color(255, 255, 255, 255)
        djui_hud_print_text(subtitle.text, x, y, text_scale)
    end
end
hook_event(HOOK_ON_HUD_RENDER, on_hud_render)