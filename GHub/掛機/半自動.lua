local WAIT_TO_START = 7 --右click後等候時間(秒)
local MACRO_NAME = 'battle' --巨集名 一定要英文
local MACRO_REST = 5 --隔 N 秒再行巨集
local EXPECTED_BATTLE_TIME = 30 --預計打怪時間(秒)

local CENTER_X, CENTER_Y
local OFFSET = 5000

function OnEvent(event, arg)
  if event == "MOUSE_BUTTON_PRESSED" and arg == 2 then
    while true do
      if IsKeyLockOn("scrolllock") then
        local MIN_X, MIN_Y, MAX_X, MAX_Y = getCorners()
        CENTER_X = math.ceil((MAX_X+ MIN_X)/2)
        CENTER_Y = math.ceil((MAX_Y + MIN_Y)/2)
      end

      if IsKeyLockOn("capslock") then
        --點怪
        moveMouse(CENTER_X + OFFSET, CENTER_Y) --右
        rightClick()
        moveMouse(CENTER_X + OFFSET, CENTER_Y + OFFSET) --右下
        rightClick()
        moveMouse(CENTER_X, CENTER_Y + OFFSET) --下
        rightClick()
        moveMouse(CENTER_X - OFFSET, CENTER_Y + OFFSET) --左下
        rightClick()
        moveMouse(CENTER_X - OFFSET, CENTER_Y) --左
        rightClick()
        moveMouse(CENTER_X - OFFSET, CENTER_Y - OFFSET) --左上
        rightClick()
        moveMouse(CENTER_X, CENTER_Y - OFFSET) --上
        rightClick()
        --等入戰
        Sleep(WAIT_TO_START * 1000)
        for iter = 0, math.ceil(EXPECTED_BATTLE_TIME/MACRO_REST) do
          PlayMacro(MACRO_NAME)
          Sleep(MACRO_REST * 1000)
        end
        AbortMacro()
        pressAndReleaseKey("escape",50)
        pressAndReleaseKey("escape",50)
        Sleep(5000)
        pressAndReleaseKey("spacebar",50)
      else break
      end
    end
  end
end
function getCorners()
    moveMouse(0, 0)
    Sleep(500)
    local minX, minY = GetMousePosition()
    OutputLogMessage("minX=%s, minY= %s\n", minX, minY)
    moveMouse(65535, 65535)
    Sleep(500)
    local maxX, maxY = GetMousePosition()
    OutputLogMessage("maxX=%s, maxY=%s\n", maxX, maxY)
    return minX, minY, maxX, maxY
end
function moveMouse(x, y)
    MoveMouseTo(x, y)
    Sleep(200)
end
function rightClick()
    pressAndReleaseMouse(3, 50)
end
function pressAndReleaseMouse(key, sleep)
    PressMouseButton(key)
    Sleep(sleep)
    ReleaseMouseButton(key)
    Sleep(sleep)
end
function pressAndReleaseKey(key,sleep)
  PressKey(key)
  Sleep(sleep)
  ReleaseKey(key)
  Sleep(sleep)
end
