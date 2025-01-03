---@class Subtitle
---@field bank_name string
---@field sound_name string
---@field text string

---@class SubtitleSet
---@field id integer
---@field name string
---@field author string
---@field locale string
---@field subtitles { [string]: Subtitle }

---@class SubtitleRegistry
---@field all SubtitleSet[]
---@field locales { [string]: integer[] }

---@type SubtitleRegistry
local SubtitleRegistry = {
    all = {},
    locales = {}
}

---Gets the subtitle text for a sound
---@param set_id integer
---@param sound SoundResult
---@return string?
function get_subtitle(set_id, sound)
    local set = SubtitleRegistry.all[set_id]
    if set == nil then
        return "SUBTITLE SET DOES NOT EXIST"
    end
    local full_name = sound.bank.name .. "/" .. sound.sound.name
    if sound.variant then
        local subtitle = set.subtitles[full_name .. "." .. sound.sound.variants[sound.variant]]
        if subtitle ~= nil then return subtitle.text end
    end
    local subtitle = set.subtitles[full_name]
    if subtitle ~= nil then return subtitle.text end
    return nil
end

---Adds a new subtitle set and returns the ID <br/>
---`name` is the friendly name (i.e. "British English") <br/>
---`locale` is the locale identifer (i.e en, en-GB, en-US) <br/>
---`fallback` is the fallback locale <br/>
---If you need help figuring out what the locale should be, ping @kermeet
---@param name string
---@param author string
---@param locale string
function add_subtitle_set(name, author, locale)
    ---@type SubtitleSet
    local set = { id = -1, name = name, author = author, locale = locale, subtitles = {} }
    table.insert(SubtitleRegistry.all, set)

    local id = #SubtitleRegistry.all
    set.id = id

    local locale_table = SubtitleRegistry.locales[locale] or {}
    SubtitleRegistry.locales[locale] = locale_table
    table.insert(locale_table, id)

    return id
end

---Adds a subtitle to a subtitle set
---@param set_id integer
---@param bank_name string
---@param sound_name string
---@param text string
function add_subtitle(set_id, bank_name, sound_name, text)
    ---@type SubtitleSet
    local set = SubtitleRegistry.all[set_id]
    if set == nil then error("Can't add subtitle to non-existent set", 2) end
    ---@type Subtitle
    local subtitle = { bank_name = bank_name, sound_name = sound_name, text = text }
    set.subtitles[bank_name .. "/" .. sound_name] = subtitle
end

--[[

    TODO:

    - Delayed subtitles (SNORING3/SLEEPTALK)
    - Custom subtitle sets
    - Subtitle set selection
    - Closed Captions

--]]
