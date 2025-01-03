---@class ActiveSubtitle
---@field text string
---@field timestamp integer
---@field time_to_live integer
---@field sound_result SoundResult?

---@type ActiveSubtitle[]
gActiveSubtitles = {}
local gActiveSubtitles = gActiveSubtitles

---@type integer
local current_time

local gSubtitleSoundQueue = gSubtitleSoundQueue
local function on_update()
    current_time = get_global_timer()

    while #gSubtitleSoundQueue > 0 do
        ---@type SoundQueueItem
        local info = gSubtitleSoundQueue[1]
        if info.sound_result.sound.type == SOUND_TYPE_VOICE then
            ---@type ActiveSubtitle
            local subtitle = {
                text = get_subtitle(SUBTITLES_EN, info.sound_result) or info.sound_result.full_name,
                timestamp = info.tick,
                time_to_live = 60,
                sound_result = info.sound_result
            }
            table.insert(gActiveSubtitles, subtitle)
        end
        table.remove(gSubtitleSoundQueue, 1)
    end

    while #gActiveSubtitles > 0 do
        ---@type ActiveSubtitle
        local subtitle = gActiveSubtitles[1]
        local end_time = subtitle.timestamp + subtitle.time_to_live
        if current_time >= end_time then
            table.remove(gActiveSubtitles, 1)
        else
            break
        end
    end
end
hook_event(HOOK_UPDATE, on_update)
