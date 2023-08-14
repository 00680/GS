local WAIT_TO_START = 7--右click後等候時間(秒)
local MACRO_NAME = 'fight' --巨集名 一定要英文
local MACRO_REST = 5 --隔 N 秒再行巨集

function OnEvent(event, arg)
  if IsKeyLockOn("capslock") and event == "MOUSE_BUTTON_PRESSED" and arg == 2 then
    Sleep(WAIT_TO_START * 1000)
            
    repeat
      PlayMacro(MACRO_NAME)
      
      Sleep(MACRO_REST * 1000)
    until not IsKeyLockOn("capslock")
  end
end
