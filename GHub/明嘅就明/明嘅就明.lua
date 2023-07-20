local MOUSE_KEYS = {
    LEFT_CLICK = 1,
    RIGHT_CLICK = 2,
    DPI_UP = 8,
    DPI_DOWN = 7,
    NEXT_PAGE = 5,
    PREV_PAGE = 4
}

local BUTTON_MAP = {
    MOUSE_BUTTON_PRESSED= {
        abc =123,
        [MOUSE_KEYS.DPI_UP] = {
            BASE_POSITION = 'up',
            KEY_TO_CENTER = 'down',
            AREA_TO_SUMMON = { minX =37702, minY = 28094, maxX = 37839, maxY = 32303 },
            BATTLE_FIELD = {
                { minX = 20154 , minY = 36038, maxX = 20554 , maxY = 36438, keyToPosition = 'left', keyToCenter = 'right' },
                { minX = 44776 , minY = 35109, maxX = 45176 , maxY = 35509, keyToPosition = 'right', keyToCenter = 'left' },
                { minX = 36239 , minY = 40411, maxX = 36639 , maxY = 40811, keyToPosition = 'down', keyToCenter = 'up' }
            }
        },
        [MOUSE_KEYS.DPI_DOWN] = {
            BASE_POSITION = 'down',
            KEY_TO_CENTER = 'up',
            AREA_TO_SUMMON = { minX = 29438, minY = 30663, maxX = 29540, maxY = 35473 },
                        BATTLE_FIELD = {
                { minX = 20154 , minY = 36038, maxX = 20554 , maxY = 36438, keyToPosition = 'left', keyToCenter = 'right' },
                { minX = 44776 , minY = 35109, maxX = 45176 , maxY = 35509, keyToPosition = 'right', keyToCenter = 'left' },
                { minX = 36239 , minY = 40411, maxX = 36639 , maxY = 40811, keyToPosition = 'up', keyToCenter = 'down' }
            }
        },
        [MOUSE_KEYS.NEXT_PAGE] = {
            BASE_POSITION = 'left',
            KEY_TO_CENTER = 'right',
            AREA_TO_SUMMON = { minX = 29438, minY = 30663, maxX = 29540, maxY = 35473 },
                       BATTLE_FIELD = {
                { minX = 0, minY = 0, maxX = 0, maxY = 0, keyToPosition = 'up', keyToCenter = 'down' },
                { minX = 0, minY = 0, maxX = 0, maxY = 0, keyToPosition = 'down', keyToCenter = 'up' },
                { minX = 44776 , minY = 35109, maxX = 45176 , maxY = 35509, keyToPosition = 'right', keyToCenter = 'left' }
            }

        },
        [MOUSE_KEYS.PREV_PAGE] = {
            BASE_POSITION = 'right',
            KEY_TO_CENTER = 'left',
            AREA_TO_SUMMON = { minX =32443, minY = 31975, maxX = 37327 , maxY = 37441 },
            BATTLE_FIELD = {
                { minX = 0, minY = 0, maxX = 0, maxY = 0, keyToPosition = 'up', keyToCenter = 'down' },
                { minX = 0, minY = 0, maxX = 0, maxY = 0, keyToPosition = 'down', keyToCenter = 'up' },
                { minX = 44776 , minY = 35109, maxX = 45176 , maxY = 35509, keyToPosition = 'left', keyToCenter = 'right' }
            }
        }
    }
}
local SUMMON_AND_DEBUFF_MACRO_NAME = 'summon'
local ATTACK_MACRO_NAME = 'attack'
local LEAVE_BATTLE_MACRO_NAME = 'leave'

function OnEvent(event, arg)
 local x, y = GetMousePosition()
    if (event=="MOUSE_BUTTON_PRESSED" and  IsKeyLockOn("capslock")) then OutputLogMessage(arg) end
   if (BUTTON_MAP[event] and BUTTON_MAP[event][arg]) then
   OutputLogMessage(BUTTON_MAP[event][arg].BASE_POSITION )
           -- Move to center
        PressKey(BUTTON_MAP[event][arg].KEY_TO_CENTER);
        Sleep(900) -- TODO: update delay time
        ReleaseKey(BUTTON_MAP[event][arg].KEY_TO_CENTER)
        Sleep(50)
        -- Summon and debuff
       -- MoveMouseTo(math.random(BUTTON_MAP[event][arg].AREA_TO_SUMMON.minX, BUTTON_MAP[event][arg].AREA_TO_SUMMON.maxX),math.random(BUTTON_MAP[event][arg].AREA_TO_SUMMON.minY, BUTTON_MAP[event][arg].AREA_TO_SUMMON.maxY))
        MoveMouseTo(math.random(31000,34000),math.random(31500,34000))
        Sleep(50)
        summonAndDeBuff();
        Sleep(1000)
        for k,v in pairs(BUTTON_MAP[event][arg].BATTLE_FIELD ) do
          PressKey(v.keyToPosition );
          Sleep(800-(k*80)) -- TODO: update delay time
          ReleaseKey(v.keyToPosition )
           Sleep(50)
          attack()
           Sleep(1800)
           PressKey(v.keyToCenter );
          Sleep(800-(k*80)) -- TODO: update delay time
          ReleaseKey(v.keyToCenter )
          Sleep(50)
           
        end
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
