EnablePrimaryMouseButtonEvents(true)

local started = false

function OnEvent(event, arg)
    if IsKeyLockOn("capslock") and event == "MOUSE_BUTTON_PRESSED" and not started then
        started = true

        local minX, minY, maxX, maxY = getCorners()
        local width = getWidth(minX, maxX)
        local height = getHeight(minY, maxY)
        OutputLogMessage("width=%s, height=%s\n", width, height)

        local absStrengthenBoxX = calcX(minX, width, 0.3010848098)
        local absStrengthenBoxY = calcY(minY, height, 0.4537127591)
        OutputLogMessage("absStrengthenBoxX=%s, absStrengthenBoxY=%s\n", absStrengthenBoxX, absStrengthenBoxY)

        local absStartStrengthenX = calcX(minX, width, 0.3724418239)
        local absStartStrengthenY = calcY(minY, height, 0.5436872361)
        OutputLogMessage("absStartStrengthenX=%s, absStartStrengthenY=%s\n", absStartStrengthenX, absStartStrengthenY)

        local absStartStengthenConfirmX = calcX(minX, width, 0.4897386725)
        local absStartStengthenConfirmY = calcY(minY, height, 0.5371514443)
        OutputLogMessage("absStartStengthenConfirmX=%s, absStartStengthenConfirmY=%s\n", absStartStengthenConfirmX, absStartStengthenConfirmY)

        local absStrengthenDoneX = calcX(minX, width, 0.5317571629)
        local absStrengthenDoneY = calcY(minY, height, 0.5423753071)
        OutputLogMessage("absStrengthenDoneX=%s, absStrengthenDoneX=%s\n", absStrengthenDoneX, absStrengthenDoneY)

        local absSecondBoxX = calcX(minX, width, 0.6021582322)
        local absSecondBoxY = calcY(minY, height, 0.5853966891)
        OutputLogMessage("absSecondBoxX=%s, absSecondBoxY=%s\n", absSecondBoxX, absSecondBoxY)

        repeat
            moveMouse(absFirstBoxX, absFirstBoxY) --第一格
            leftClick() --拎起

            moveMouse(absStrengthenBoxX, absStrengthenBoxY) --強化格
            leftClick() --放低

            moveMouse(absStartStrengthenX, absStartStrengthenY) --確定強化
            leftClick()

            moveMouse(absStartStengthenConfirmX, absStartStengthenConfirmY) --確定
            leftClick()
            Sleep(2000) --progress bar

            moveMouse(absStrengthenDoneX, absStrengthenDoneY) --確定
            leftClick()

            moveMouse(absSecondBoxX, absSecondBoxY) --第二格
            leftClick() --拎起
            moveMouse(absFirstBoxX, absFirstBoxY) --第一格
            leftClick() --放低
            rightClick()

            Sleep(200)
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
    pressAndReleaseMouse(1, 50)
end

function rightClick()
    pressAndReleaseMouse(3, 50)
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
