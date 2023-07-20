local MOUSE_KEYS = {
    LEFT_CLICK = 0,
    RIGHT_CLICK = 1,
    DPI_UP = 3,
    DPI_DOWN = 4,
    NEXT_PAGE = 5,
    PREV_PAGE = 6
}

local BUTTON_MAP = {
    MOUSE_BUTTON_PRESSED = {
        [MOUSE_KEYS.DPI_UP] = {
            BASE_POSITION = 'up',
            KEY_TO_CENTER = 'down',
            AREA_TO_SUMMON = { minX = 0, minY = 0, maxX = 0, maxY = 0 }
        },
        [MOUSE_KEYS.DPI_DOWN] = {
            BASE_POSITION = 'down',
            KEY_TO_CENTER = 'up',
            AREA_TO_SUMMON = { minX = 0, minY = 0, maxX = 0, maxY = 0 }
        },
        [MOUSE_KEYS.NEXT_PAGE] = {
            BASE_POSITION = 'left',
            KEY_TO_CENTER = 'right',
            AREA_TO_SUMMON = { minX = 0, minY = 0, maxX = 0, maxY = 0 }
        },
        [MOUSE_KEYS.PREV_PAGE] = {
            BASE_POSITION = 'right',
            KEY_TO_CENTER = 'left',
            AREA_TO_SUMMON = { minX = 0, minY = 0, maxX = 0, maxY = 0 },
            BATTLE_FIELD = {
                { minX = 0, minY = 0, maxX = 0, maxY = 0, keyToPosition = 'up', keyToCenter = 'down' },
                { minX = 0, minY = 0, maxX = 0, maxY = 0, keyToPosition = 'down', keyToCenter = 'up' },
                { minX = 0, minY = 0, maxX = 0, maxY = 0, keyToPosition = 'right', keyToCenter = 'left' }
            }
        }
    }
}
local SUMMON_AND_DEBUFF_MACRO_NAME = '陰念坦'
local ATTACK_MACRO_NAME = '輸出'
local LEAVE_BATTLE_MACRO_NAME = '走場'

function OnEvent(event, arg)
    if (BUTTON_MAP[event] and BUTTON_MAP[event][arg]) then
        -- Move to center
        PressKey(BUTTON_MAP[event][arg].KEY_TO_CENTER);
        Sleep(2000) -- TODO: update delay time
        ReleaseKey(BUTTON_MAP[event][arg].KEY_TO_CENTER)

        -- Summon and debuff
        MoveMouseTo(
                math.random(BUTTON_MAP[event][arg].AREA_TO_SUMMON.minX, BUTTON_MAP[event][arg].AREA_TO_SUMMON.maxX),
                math.random(BUTTON_MAP[event][arg].AREA_TO_SUMMON.minY, BUTTON_MAP[event][arg].AREA_TO_SUMMON.maxY)
        )
        summonAndDeBuff();

        Sleep(50)

        firstField
    end
end

function summonAndDeBuff()
    PlayMacro(SUMMON_AND_DEBUFF_MACRO_NAME)
end

function attack()
    PlayMacro(ATTACK_MACRO_NAME)
end

function leaveBattle()
    AbortMacro()
    PlayMacro(LEAVE_BATTLE_MACRO_NAME)
end
