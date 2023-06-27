EnablePrimaryMouseButtonEvents(true)

local started = false

function OnEvent(event, arg)
    if IsKeyLockOn("capslock") and event == "MOUSE_BUTTON_PRESSED" and not started then
        started = true

        local minX, minY, maxX, maxY = getCorners()
        
        local width = getWidth(minX, maxX)
        local height = getHeight(minY, maxY)
        OutputLogMessage("width=%s, height=%s\n", width, height)

        local absFirstBoxX = calcX(minX ,width ,0.6031141769)
        local absFirstBoxY = calcY(minY ,height ,0.494144026)
        OutputLogMessage("absFirstBoxX = %s, absFirstBoxY = %s\n", absFirstBoxX,absFirstBoxY)

        local abConfirmX = calcX(minX, width, 0.5317571629)
        local abConfirmY = calcY(minY, height, 0.5423753071)
        OutputLogMessage("abConfirmX =%s, abConfirmY =%s\n", abConfirmX , abConfirmY )

        repeat
            moveMouse(absFirstBoxX, absFirstBoxY) --第一格
            rightClick() --拎起
 
            moveMouse(abConfirmX , abConfirmY ) --確定
            leftClick()
        until not IsKeyLockOn("capslock")

        started = false
    end
end

function moveMouse(x, y)
    MoveMouseTo(x, y)
    Sleep(250)
end

function pressAndReleaseMouse(key, sleep)
    PressMouseButton(key)
    Sleep(sleep)
    ReleaseMouseButton(key)
    Sleep(sleep)
end

function leftClick()
    pressAndReleaseMouse(1, 40)
end

function rightClick()
    pressAndReleaseMouse(3, 40)
end

function getWidth(minX, maxX)
    return maxX - minX
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

function calcX(minX, width, post)
    return math.floor(minX + (width * post))
end

function calcY(minY, height, post)
    return math.floor(minY + (height * post))
end

function getHeight(minY, maxY)
    return maxY - minY
end
