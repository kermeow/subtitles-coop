---@class SoundBank
---@field name string
---@field unique_banks boolean
---@field bank_ids integer[]
---@field sounds Sound[]

---@class Sound
---@field id integer
---@field name string
---@field type SoundType
---@field variants string[]?

---@class SoundType : integer
---@type SoundType
SOUND_TYPE_VOICE = 0
---@type SoundType
SOUND_TYPE_EFFECT = 1
---@type SoundType
SOUND_TYPE_VOICE_EFFECT = 2

---@type SoundBank[]
MOD_SOUND_BANKS = {}
local MOD_SOUND_BANKS = MOD_SOUND_BANKS

---@type SoundBank[]
MOD_SOUND_BANKS_BY_ID = {}
local MOD_SOUND_BANKS_BY_ID = MOD_SOUND_BANKS_BY_ID

do -- Game sounds
    ---@param name string
    ---@param unique_banks boolean
    ---@param bank_ids integer[]
    local function create_soundbank(name, unique_banks, bank_ids)
        if type(bank_ids) == "number" then bank_ids = { bank_ids } end
        ---@type SoundBank
        local bank = {
            name = name,
            unique_banks = unique_banks,
            bank_ids = bank_ids,
            sounds = {}
        }
        table.insert(MOD_SOUND_BANKS, bank)
        for _, bank_id in next, bank_ids do
            MOD_SOUND_BANKS_BY_ID[bank_id] = bank
        end
        return bank
    end

    local ACTION_BANK = create_soundbank("ACTION", false, SOUND_BANK_ACTION)
    local MOVING_BANK = create_soundbank("MOVING", false, SOUND_BANK_MOVING)
    local VOICE_BANK = create_soundbank("VOICE", false,
        { SOUND_BANK_MARIO_VOICE, SOUND_BANK_LUIGI_VOICE, SOUND_BANK_TOAD_VOICE, SOUND_BANK_WARIO_VOICE }
    )
    local GENERAL_BANK = create_soundbank("GENERAL", true, { SOUND_BANK_GENERAL, SOUND_BANK_GENERAL2 })
    local OBJECT_BANK = create_soundbank("OBJECT", true, { SOUND_BANK_OBJ, SOUND_BANK_OBJ2 })
    local ENVIRONMENT_BANK = create_soundbank("ENVIRONMENT", false, SOUND_BANK_ENV)
    local AIR_BANK = create_soundbank("AIR", false, SOUND_BANK_AIR) -- lol ok
    local MENU_BANK = create_soundbank("MENU", false, SOUND_BANK_MENU)

    ---@param bank_id integer
    ---@param sound_id integer
    ---@param name string
    ---@param type SoundType
    local function add_sound(bank_id, sound_id, name, type)
        ---@type SoundBank
        local bank = MOD_SOUND_BANKS_BY_ID[bank_id]
        if bank.unique_banks then
            sound_id = sound_id + (bank_id << 8)
        end
        ---@type Sound
        local sound = { id = sound_id, name = name, type = type }
        table.insert(bank.sounds, sound)
        return sound
    end

    local function add_terrain_sound(bank_id, sound_id, name, type)
        ---@type SoundBank
        local bank = MOD_SOUND_BANKS_BY_ID[bank_id]
        local sound = add_sound(bank_id, sound_id, name, type)
        sound.variants = {
            [SOUND_TERRAIN_DEFAULT] = "",
            [SOUND_TERRAIN_GRASS] = "GRASS",
            [SOUND_TERRAIN_WATER] = "WATER",
            [SOUND_TERRAIN_STONE] = "STONE",
            [SOUND_TERRAIN_SPOOKY] = "SPOOKY",
            [SOUND_TERRAIN_SNOW] = "SNOW",
            [SOUND_TERRAIN_ICE] = "ICE",
            [SOUND_TERRAIN_SAND] = "SAND",
        }
    end

    do -- ACTION
        local bank = SOUND_BANK_ACTION

        add_terrain_sound(bank, 0x00, "TERRAIN_JUMP", SOUND_TYPE_EFFECT)
        add_terrain_sound(bank, 0x08, "TERRAIN_LANDING", SOUND_TYPE_EFFECT)
        add_terrain_sound(bank, 0x10, "TERRAIN_STEP", SOUND_TYPE_EFFECT)
        add_terrain_sound(bank, 0x18, "TERRAIN_BODY_HIT_GROUND", SOUND_TYPE_EFFECT)
        add_terrain_sound(bank, 0x20, "TERRAIN_STEP_TIPTOE", SOUND_TYPE_EFFECT)
        add_terrain_sound(bank, 0x48, "TERRAIN_STUCK_IN_GROUND", SOUND_TYPE_EFFECT)
        add_terrain_sound(bank, 0x60, "TERRAIN_HEAVY_LANDING", SOUND_TYPE_EFFECT)

        add_sound(bank, 0x28, "METAL_JUMP", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x29, "METAL_LANDING", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x2A, "METAL_STEP", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x2B, "METAL_HEAVY_LANDING", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x2F, "METAL_STEP_TIPTOE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x2C, "CLAP_HANDS_COLD", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x2D, "HANGING_STEP", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x2E, "QUICKSAND_STEP", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x33, "SWIM", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x35, "THROW", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x37, "SPIN", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x38, "TWIRL", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x3A, "CLIMB_UP_TREE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x3B, "CLIMB_DOWN_TREE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x3F, "PAT_BACK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x40, "BRUSH_HAIR", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x41, "CLIMB_UP_POLE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x42, "METAL_BONK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x43, "UNSTUCK_FROM_GROUND", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x44, "HIT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x45, "BONK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x46, "SHRINK_INTO_BBH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x47, "SWIM_FAST", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x50, "METAL_JUMP_WATER", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x51, "METAL_LAND_WATER", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x52, "METAL_STEP_WATER", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x56, "FLYING_FAST", SOUND_TYPE_EFFECT)       -- unverified according to sounds.h
        add_sound(bank, 0x57, "TELEPORT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x59, "BOUNCE_OFF_OBJECT", SOUND_TYPE_EFFECT) -- unverified according to sounds.h
        add_sound(bank, 0x5A, "SIDE_FLIP", SOUND_TYPE_EFFECT)         -- unverified according to sounds.h
        add_sound(bank, 0x5B, "READ_SIGN", SOUND_TYPE_EFFECT)
    end

    do -- MOVING
        local bank = SOUND_BANK_MOVING

        add_terrain_sound(bank, 0x00, "TERRAIN_SLIDE", SOUND_TYPE_EFFECT)
        add_terrain_sound(bank, 0x20, "TERRAIN_RIDING_SHELL", SOUND_TYPE_EFFECT)

        add_sound(bank, 0x10, "LAVA_BURN", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x11, "SLIDE_DOWN_POLE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x12, "SLIDE_DOWN_TREE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x14, "QUICKSAND_DEATH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x16, "SHOCKED", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x17, "FLYING", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x18, "ALMOST_DROWNING", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x19, "AIM_CANNON", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x28, "RIDING_SHELL_LAVA", SOUND_TYPE_EFFECT)
    end

    do -- VOICE
        local sounds = MOD_SOUND_BANKS_BY_ID[SOUND_BANK_MARIO_VOICE].sounds
        MOD_SOUND_BANKS_BY_ID[SOUND_BANK_LUIGI_VOICE].sounds = sounds
        MOD_SOUND_BANKS_BY_ID[SOUND_BANK_TOAD_VOICE].sounds = sounds
        MOD_SOUND_BANKS_BY_ID[SOUND_BANK_WARIO_VOICE].sounds = sounds

        local bank = SOUND_BANK_MARIO_VOICE

        add_sound(bank, 0x00, "YAH", SOUND_TYPE_VOICE)
        add_sound(bank, 0x01, "WAH", SOUND_TYPE_VOICE)
        add_sound(bank, 0x02, "HOO", SOUND_TYPE_VOICE)
        add_sound(bank, 0x03, "HOOHOO", SOUND_TYPE_VOICE)
        add_sound(bank, 0x04, "YAHOO", SOUND_TYPE_VOICE)
        add_sound(bank, 0x05, "UH", SOUND_TYPE_VOICE)
        add_sound(bank, 0x06, "HRMM", SOUND_TYPE_VOICE)
        add_sound(bank, 0x07, "WAH", SOUND_TYPE_VOICE)
        add_sound(bank, 0x08, "WHOA", SOUND_TYPE_VOICE)
        add_sound(bank, 0x09, "EEUH", SOUND_TYPE_VOICE)
        add_sound(bank, 0x0A, "ATTACKED", SOUND_TYPE_VOICE)
        add_sound(bank, 0x0B, "OOOF", SOUND_TYPE_VOICE)
        add_sound(bank, 0x0C, "HERE_WE_GO", SOUND_TYPE_VOICE)
        add_sound(bank, 0x0D, "YAWNING", SOUND_TYPE_VOICE)
        add_sound(bank, 0x0E, "SNORING", SOUND_TYPE_VOICE)
        add_sound(bank, 0x0F, "SNORING", SOUND_TYPE_VOICE)
        add_sound(bank, 0x10, "WAAAOOOW", SOUND_TYPE_VOICE)
        add_sound(bank, 0x11, "HAHA", SOUND_TYPE_VOICE)
        add_sound(bank, 0x13, "UH2", SOUND_TYPE_VOICE)
        add_sound(bank, 0x14, "ON_FIRE", SOUND_TYPE_VOICE)
        add_sound(bank, 0x15, "DYING", SOUND_TYPE_VOICE)
        add_sound(bank, 0x16, "PANTING", SOUND_TYPE_VOICE)
        add_sound(bank, 0x18, "PANTING", SOUND_TYPE_VOICE)
        add_sound(bank, 0x19, "PANTING", SOUND_TYPE_VOICE)
        add_sound(bank, 0x1A, "PANTING", SOUND_TYPE_VOICE)
        add_sound(bank, 0x1B, "COUGHING", SOUND_TYPE_VOICE)
        add_sound(bank, 0x1C, "COUGHING", SOUND_TYPE_VOICE)
        add_sound(bank, 0x1D, "COUGHING", SOUND_TYPE_VOICE)
        add_sound(bank, 0x1E, "YAH", SOUND_TYPE_VOICE)
        add_sound(bank, 0x1F, "HOO", SOUND_TYPE_VOICE)
        add_sound(bank, 0x20, "MAMA_MIA", SOUND_TYPE_VOICE)
        add_sound(bank, 0x21, "OKEY_DOKEY", SOUND_TYPE_VOICE)
        add_sound(bank, 0x22, "WAH", SOUND_TYPE_VOICE)
        add_sound(bank, 0x23, "DROWNING", SOUND_TYPE_VOICE)
        add_sound(bank, 0x24, "WAH", SOUND_TYPE_VOICE)
        add_sound(bank, 0x2B, "YAHOO", SOUND_TYPE_VOICE)
        add_sound(bank, 0x2C, "YAHOO", SOUND_TYPE_VOICE)
        add_sound(bank, 0x2D, "YAHOO", SOUND_TYPE_VOICE)
        add_sound(bank, 0x2E, "WAHA", SOUND_TYPE_VOICE)
        add_sound(bank, 0x2F, "YIPPEE", SOUND_TYPE_VOICE)
        add_sound(bank, 0x30, "DOH", SOUND_TYPE_VOICE)
        add_sound(bank, 0x31, "GAME_OVER", SOUND_TYPE_VOICE)
        add_sound(bank, 0x32, "HELLO", SOUND_TYPE_VOICE)
        add_sound(bank, 0x33, "PRESS_START_TO_PLAY", SOUND_TYPE_VOICE)
        add_sound(bank, 0x34, "TWIRL_BOUNCE", SOUND_TYPE_VOICE)
        add_sound(bank, 0x35, "SNORING", SOUND_TYPE_VOICE)
        add_sound(bank, 0x36, "SO_LONGA_BOWSER", SOUND_TYPE_VOICE)
        add_sound(bank, 0x37, "IMA_TIRED", SOUND_TYPE_VOICE)
        add_sound(bank, 0x38, "LETS_A_GO", SOUND_TYPE_VOICE)

        -- Do Peach voicelines need to be subtitled? Usually include existing subtitles/text afaik
        -- add_sound(bank, 0x28, "PEACH_LETTER", SOUND_TYPE_VOICE) -- SOUND_PEACH_DEAR_MARIO
    end

    do -- GENERAL
        local bank = SOUND_BANK_GENERAL

        add_sound(bank, 0x00, "ACTIVATE_CAP_SWITCH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x03, "FLAME_OUT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x04, "OPEN_WOOD_DOOR", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x05, "CLOSE_WOOD_DOOR", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x06, "OPEN_IRON_DOOR", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x07, "CLOSE_IRON_DOOR", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x08, "BUBBLES", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x09, "MOVING_WATER", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0A, "SWISH_WATER", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0B, "QUIET_BUBBLE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0C, "VOLCANO_EXPLOSION", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0D, "QUIET_BUBBLE2", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0E, "CASTLE_TRAP_OPEN", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0F, "WALL_EXPLOSION", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x11, "COIN", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x12, "COIN_WATER", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x16, "SHORT_STAR", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x17, "BIG_CLOCK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x20, "OPEN_CHEST", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x22, "CLAM_SHELL1", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x24, "BOX_LANDING", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x26, "CLAM_SHELL2", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x27, "CLAM_SHELL3", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x28, "PAINTING_EJECT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x2B, "LEVEL_SELECT_CHANGE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x2D, "PLATFORM", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x2E, "DONUT_PLATFORM_EXPLOSION", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x2F, "BOWSER_BOMB_EXPLOSION", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x30, "COIN_SPURT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x34, "BOAT_TILT1", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x35, "BOAT_TILT2", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x36, "COIN_DROP", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x38, "PENDULUM_SWING", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x39, "CHAIN_CHOMP1", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x3A, "CHAIN_CHOMP2", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x3B, "DOOR_TURN_KEY", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x3C, "MOVING_IN_SAND", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x3E, "MOVING_PLATFORM_SWITCH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x3F, "CAGE_OPEN", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x40, "QUIET_POUND1", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x41, "BREAK_BOX", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x42, "DOOR_INSERT_KEY", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x43, "QUIET_POUND2", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x44, "BIG_POUND", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x47, "CANNON_UP", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x48, "GRINDEL_ROLL", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x49, "EXPLOSION7", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x4A, "SHAKE_COFFIN", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x4D, "RACE_GUN_SHOT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x4E, "STAR_DOOR_OPEN", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x4F, "STAR_DOOR_CLOSE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x56, "POUND_ROCK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x57, "STAR_APPEARS", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x58, "COLLECT_1UP", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x5A, "BUTTON_PRESS", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x5B, "ELEVATOR_MOVE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x5C, "SWISH_AIR", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x5D, "HAUNTED_CHAIR", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x5E, "SOFT_LANDING", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x5F, "HAUNTED_CHAIR_MOVE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x62, "BOWSER_PLATFORM", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x64, "HEART_SPIN", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x65, "POUND_WOOD_POST", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x66, "WATER_LEVEL_TRIG", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x67, "SWITCH_DOOR_OPEN", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x68, "RED_COIN", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x69, "BIRDS_FLY_AWAY", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x6B, "METAL_POUND", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x6C, "BOING1", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x6D, "BOING2", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x6E, "YOSHI_WALK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x6F, "ENEMY_ALERT1", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x70, "YOSHI_TALK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x71, "SPLATTERING", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x73, "GRAND_STAR", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x74, "GRAND_STAR_JUMP", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x75, "BOAT_ROCK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x76, "VANISH_SFX", SOUND_TYPE_EFFECT)

        bank = SOUND_BANK_GENERAL2

        add_sound(bank, 0x2E, "BOBOMB_EXPLOSION", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x3E, "PURPLE_SWITCH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x40, "ROTATING_BLOCK_CLICK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x48, "SPINDEL_ROLL", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x4B, "PYRAMID_TOP_SPIN", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x4C, "PYRAMID_TOP_EXPLOSION", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x50, "BIRD_CHIRP2", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x54, "SWITCH_TICK_FAST", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x55, "SWITCH_TICK_SLOW", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x57, "STAR_APPEARS", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x59, "ROTATING_BLOCK_ALERT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x60, "BOWSER_EXPLODE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x61, "BOWSER_KEY", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x63, "1UP_APPEAR", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x6A, "RIGHT_ANSWER", SOUND_TYPE_EFFECT)
    end

    do -- ENVIRONMENT
        local bank = SOUND_BANK_ENV

        add_sound(bank, 0x00, "WATERFALL1", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x01, "WATERFALL2", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x02, "ELEVATOR1", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x03, "DRONING1", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x04, "DRONING2", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x05, "WIND1", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x06, "MOVING_SAND_SNOW", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x08, "ELEVATOR2", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x09, "WATER", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0B, "BOAT_ROCKING1", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0C, "ELEVATOR3", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0D, "ELEVATOR4", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0E, "MOVINGSAND", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0F, "MERRY_GO_ROUND_CREAKING", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x10, "WIND2", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x13, "SLIDING", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x14, "STAR", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x16, "WATER_DRAIN", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x17, "METAL_BOX_PUSH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x18, "SINK_QUICKSAND", SOUND_TYPE_EFFECT)
    end

    do -- OBJECT
        local bank = SOUND_BANK_OBJ

        add_sound(bank, 0x00, "SUSHI_SHARK_WATER_SOUND", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x01, "MRI_SHOOT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x02, "BABY_PENGUIN_WALK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x03, "BOWSER_WALK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x05, "BOWSER_TAIL_PICKUP", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x06, "BOWSER_DEFEATED", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x07, "BOWSER_SPINNING", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x08, "BOWSER_INHALING", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x09, "BIG_PENGUIN_WALK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0A, "BOO_BOUNCE_TOP", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0B, "BOO_LAUGH_SHORT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0C, "THWOMP", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0D, "CANNON1", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0E, "CANNON2", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0F, "CANNON3", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x12, "JUMP_WALK_WATER", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x14, "MRI_DEATH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x15, "POUNDING1", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x16, "KING_BOBOMB", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x17, "BULLY_METAL", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x18, "BULLY_EXPLODE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x1A, "POUNDING_CANNON", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x1B, "BULLY_WALK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x1F, "BABY_PENGUIN_DIVE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x20, "GOOMBA_WALK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x21, "UKIKI_CHATTER_LONG", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x22, "MONTY_MOLE_ATTACK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x22, "EVIL_LAKITU_THROW", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x24, "DYING_ENEMY1", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x25, "CANNON4", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x26, "DYING_ENEMY2", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x27, "BOBOMB_WALK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x28, "SOMETHING_LANDING", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x29, "DIVING_IN_WATER", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x2A, "SNOW_SAND1", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x2B, "SNOW_SAND2", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x2C, "DEFAULT_DEATH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x2D, "BIG_PENGUIN_YELL", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x2E, "WATER_BOMB_BOUNCING", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x2F, "GOOMBA_ALERT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x2F, "WIGGLER_JUMP", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x30, "STOMPED", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x32, "DIVING_INTO_WATER", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x33, "PIRANHA_PLANT_SHRINK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x34, "KOOPA_THE_QUICK_WALK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x35, "KOOPA_WALK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x36, "BULLY_WALKING", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x37, "DORRIE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x38, "BOWSER_LAUGH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x39, "UKIKI_CHATTER_SHORT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x3A, "UKIKI_CHATTER_IDLE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x3B, "UKIKI_STEP_DEFAULT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x3C, "UKIKI_STEP_LEAVES", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x3D, "KOOPA_TALK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x3E, "KOOPA_DAMAGE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x3F, "KLEPTO1", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x40, "KLEPTO2", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x41, "KING_BOBOMB_TALK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x46, "KING_BOBOMB_JUMP", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x47, "KING_WHOMP_DEATH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x48, "BOO_LAUGH_LONG", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x4A, "EEL", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x4B, "EYEROK_SHOW_EYE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x4C, "MR_BLIZZARD_ALERT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x4D, "SNUFIT_SHOOT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x4E, "SKEETER_WALK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x4F, "WALKING_WATER", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x51, "BIRD_CHIRP3", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x54, "PIRANHA_PLANT_APPEAR", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x55, "FLAME_BLOWN", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x56, "MAD_PIANO_CHOMPING", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x58, "BOBOMB_BUDDY_TALK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x5C, "WIGGLER_HIGH_PITCH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x5D, "HEAVEHO_TOSSED", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x5E, "WIGGLER_DEATH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x5F, "BOWSER_INTRO_LAUGH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x60, "ENEMY_DEATH_HIGH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x61, "ENEMY_DEATH_LOW", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x62, "SWOOP_DEATH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x63, "KOOPA_FLYGUY_DEATH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x63, "POKEY_DEATH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x64, "SNOWMAN_BOUNCE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x65, "SNOWMAN_EXPLODE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x68, "POUNDING_LOUD", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x6A, "MIPS_RABBIT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x6C, "MIPS_RABBIT_WATER", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x6D, "EYEROK_EXPLODE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x6E, "CHUCKYA_DEATH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x6F, "WIGGLER_TALK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x70, "WIGGLER_ATTACKED", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x71, "WIGGLER_LOW_PITCH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x72, "SNUFIT_SKEETER_DEATH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x73, "BUBBA_CHOMP", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x74, "ENEMY_DEFEAT_SHRINK", SOUND_TYPE_EFFECT)

        bank = SOUND_BANK_OBJ2

        add_sound(bank, 0x04, "BOWSER_ROAR", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x10, "PIRANHA_PLANT_BITE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x11, "PIRANHA_PLANT_DYING", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x19, "BOWSER_PUZZLE_PIECE_MOVE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x1C, "BULLY_ATTACKED", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x42, "KING_BOBOMB_DAMAGE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x43, "SCUTTLEBUG_WALK", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x44, "SCUTTLEBUG_ALERT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x45, "BABY_PENGUIN_YELL", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x49, "SWOOP", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x52, "BIRD_CHIRP1", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x57, "LARGE_BULLY_ATTACKED", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x5A, "EYEROK_SOUND_SHORT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x5A, "WHOMP_SOUND_SHORT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x5B, "EYEROK_SOUND_LONG", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x66, "BOWSER_TELEPORT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x67, "MONTY_MOLE_APPEAR", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x69, "BOSS_DIALOG_GRUNT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x6B, "MRI_SPINNING", SOUND_TYPE_EFFECT)
    end

    do -- AIR
        local bank = SOUND_BANK_AIR

        add_sound(bank, 0x00, "BOWSER_SPIT_FIRE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x02, "LAKITU_FLY", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x03, "AMP_BUZZ", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x04, "BLOW_FIRE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x04, "BLOW_WIND", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x05, "ROUGH_SLIDE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x06, "HEAVEHO_MOVE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x08, "BOBOMB_LIT_FUSE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x09, "HOWLING_WIND", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0A, "CHUCKYA_MOVE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0B, "PEACH_TWINKLE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x10, "CASTLE_OUTDOORS_AMBIENT", SOUND_TYPE_EFFECT)
    end

    do -- MENU
        local bank = SOUND_BANK_MENU

        add_sound(bank, 0x00, "CHANGE_SELECT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x02, "PAUSE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x03, "PAUSE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x04, "MESSAGE_APPEAR", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x05, "MESSAGE_DISAPPEAR", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x06, "CAMERA_ZOOM_IN", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x07, "CAMERA_ZOOM_OUT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x08, "PINCH_MARIO_FACE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x09, "LET_GO_MARIO_FACE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0A, "HAND_APPEAR", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0B, "HAND_DISAPPEAR", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0D, "POWER_METER", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0E, "CAMERA_BUZZ", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x0F, "CAMERA_TURN", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x11, "CLICK_FILE_SELECT", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x13, "MESSAGE_NEXT_PAGE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x14, "COIN_ITS_A_ME_MARIO", SOUND_TYPE_VOICE)
        add_sound(bank, 0x15, "YOSHI_GAIN_LIVES", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x16, "ENTER_PIPE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x17, "EXIT_PIPE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x18, "BOWSER_LAUGH", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x19, "ENTER_HOLE", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x1A, "CLICK_CHANGE_VIEW", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x1D, "MARIO_CASTLE_WARP", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x1E, "STAR_SOUND", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x1F, "THANK_YOU_PLAYING_MY_GAME", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x22, "MARIO_CASTLE_WARP2", SOUND_TYPE_EFFECT)
        -- add_sound(bank, 0x23, "STAR_SOUND_OKEY_DOKEY", SOUND_TYPE_VOICE)
        -- add_sound(bank, 0x24, "STAR_SOUND_LETS_A_GO", SOUND_TYPE_VOICE)
        add_sound(bank, 0x28, "COLLECT_RED_COIN", SOUND_TYPE_EFFECT)
        add_sound(bank, 0x30, "COLLECT_SECRET", SOUND_TYPE_EFFECT)
    end
end

---@class SoundResult
---@field bank SoundBank
---@field sound Sound
---@field variant integer?

---@type SoundResult[][]
local cached_results = {}

---@param bank_id integer
---@param sound_id integer
---@return SoundResult?
function find_sound(bank_id, sound_id)
    if cached_results[bank_id] and cached_results[bank_id][sound_id] then
        return cached_results[bank_id][sound_id]
    end

    local bank = MOD_SOUND_BANKS_BY_ID[bank_id]
    if not bank then return end
    if bank.unique_banks then
        sound_id = sound_id + (bank_id << 8)
    end

    local sound, variant
    for _, value in next, bank.sounds do
        if value.id == sound_id then
            sound = value
            break
        end
        if not value.variants then
            goto search_next_sound
        end
        local variants = #value.variants
        local difference = sound_id - value.id
        if difference < variants then
            sound = value
            variant = difference
            break
        end
        ::search_next_sound::
    end
    if not sound then return end

    ---@type SoundResult
    local result = { bank = bank, sound = sound, variant = variant }

    local cached_bank = cached_results[bank_id] or {}
    cached_bank[sound_id] = result
    cached_results[bank_id] = cached_bank

    return result
end
