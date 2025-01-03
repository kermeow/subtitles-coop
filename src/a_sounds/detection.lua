local sound_flag_names = {
    -- Upper flags
    [SOUND_NO_VOLUME_LOSS] = "SOUND_NO_VOLUME_LOSS",
    [SOUND_VIBRATO] = "SOUND_VIBRATO",
    [SOUND_NO_PRIORITY_LOSS] = "SOUND_NO_PRIORITY_LOSS",
    [SOUND_CONSTANT_FREQUENCY] = "SOUND_CONSTANT_FREQUENCY",
    -- Lower flags
    [SOUND_LOWER_BACKGROUND_MUSIC] = "SOUND_LOWER_BACKGROUND_MUSIC",
    [SOUND_NO_ECHO] = "SOUND_NO_ECHO",
    [SOUND_DISCRETE] = "SOUND_DISCRETE",
}

---@class SoundQueueItem
---@field sound_result SoundResult
---@field upper_flags integer
---@field lower_flags integer
---@field tick integer
---@field pos Vec3f

---@type SoundQueueItem[]
gSubtitleSoundQueue = {}
local gSubtitleSoundQueue = gSubtitleSoundQueue

---@param bits integer
---@param pos Vec3f
local function on_play_sound(bits, pos)
    local bank_id = (bits & SOUNDARGS_MASK_BANK) >> SOUNDARGS_SHIFT_BANK
    local sound_id = (bits & SOUNDARGS_MASK_SOUNDID) >> SOUNDARGS_SHIFT_SOUNDID

    local upper_flags = bits & 0x0f000000
    local lower_flags = bits & 0x000000f0

    if bank_id ~= SOUND_BANK_MOVING and lower_flags & SOUND_DISCRETE == 0 then return end

    -- special cases
    if bank_id == SOUND_BANK_MENU then
        if sound_id == 0x23 then -- STAR_SOUND_OKEY_DOKEY
            bank_id = SOUND_BANK_MARIO_VOICE
            sound_id = 0x21
        elseif sound_id == 0x24 then -- STAR_SOUND_OKEY_DOKEY
            bank_id = SOUND_BANK_MARIO_VOICE
            sound_id = 0x38
        end
    end

    local sound = find_sound(bank_id, sound_id)

    if sound == nil then
        local bank = gSoundBanksById[bank_id]
        if bank == nil then
            log_to_console(
                string.format("SUBTITLES: Unregistered bank and sound! %01x %02x", bank_id, sound_id),
                CONSOLE_MESSAGE_ERROR
            )
            return
        end
        log_to_console(
            string.format("SUBTITLES: Unregistered sound! %s (%01x) %02x", bank.name, bank_id, sound_id),
            CONSOLE_MESSAGE_ERROR
        )
        return
    end

    ---@type SoundQueueItem
    local queuedSound = {
        sound_result = sound,
        upper_flags = upper_flags,
        lower_flags = lower_flags,
        tick = get_global_timer(),
        pos = pos
    }

    while #gSubtitleSoundQueue >= 256 do -- avoid filling up memory
        table.remove(gSubtitleSoundQueue, 1)
    end
    table.insert(gSubtitleSoundQueue, queuedSound)
end
hook_event(HOOK_ON_PLAY_SOUND, on_play_sound)
