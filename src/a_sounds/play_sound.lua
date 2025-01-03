local function string_split(s, sep)
    local parts = {}
    local pattern = "%S+"
    if sep ~= nil then pattern = "([^" .. sep .. "]+)" end
    for part in string.gmatch(s, pattern) do
        table.insert(parts, part)
    end
    return parts
end

local function on_sound_command(varg)
    local args = string_split(varg, " ")

    if #args < 2 or #args > 3 then
        return false
    end

    local bank_sid = "SOUND_BANK_" .. string.upper(args[1])
    local sound_sid = string.upper(args[2])

    local bank_id = _ENV[bank_sid]
    if bank_sid == "COUNT" or bank_id == nil then
        djui_chat_message_create(string.format("Unknown sound bank: %s", bank_sid))
        return true
    end

    local mod_bank = MOD_SOUND_BANKS_BY_ID[bank_id]
    local sound
    for _, value in next, mod_bank.sounds do
        if value.name == sound_sid then
            sound = value
            break
        end
    end
    if sound == nil then
        djui_chat_message_create(string.format("Unknown sound in bank %s: %s", bank_sid, sound_sid))
        return true
    end

    local sound_id = sound.id
    if sound.variants ~= nil and #args == 3 then
        local variant_sid = string.upper(args[3])
        for variant, sid in next, sound.variants do
            if sid == variant_sid then
                sound_id = sound_id + variant
                break
            end
        end
    end

    local bits = (bank_id << SOUNDARGS_SHIFT_BANK) + (sound_id << SOUNDARGS_SHIFT_SOUNDID)
    bits = bits + SOUND_NO_VOLUME_LOSS + SOUND_DISCRETE
    bits = bits + SOUND_STATUS_WAITING

    log_to_console(string.format("%08x ", bits) .. string.format(" %08x", SOUND_MARIO_WAH2))
    play_sound(bits, gMarioStates[0].marioObj.header.gfx.cameraToObject)

    return true
end
hook_chat_command("sub sound", "Plays a sound from a bank", on_sound_command)
