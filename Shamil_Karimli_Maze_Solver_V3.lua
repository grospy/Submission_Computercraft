turtle.refuel(1)
-- Объявление переменных
local facing = 0  -- 0: Север, 1: Восток, 2: Юг, 3: Запад
local startX, startY = 1, 1  -- Начальная позиция
local endX, endY = 5, 5  -- Конечная позиция

-- Функция поворота черепахи вправо
local function turnRight()
    turtle.turnRight()
    facing = (facing + 1) % 4
end

-- Функция перемещения черепахи вперед и обновления ее положения.
local function moveForward()
    while not turtle.forward() do
        if turtle.detect() then
            turtle.dig()
        elseif turtle.attack() then
            turtle.dig()
        else
            turtle.turnLeft()
        end
    end

    local dx, dy = (facing == 1 and 1) or (facing == 3 and -1) or 0, (facing == 0 and -1) or (facing == 2 and 1) or 0
    startX, startY = startX + dx, startY + dy
end

-- Функция разворота черепахи
local function turnAround()
    turtle.turnLeft()
    turtle.turnLeft()
    facing = (facing + 2) % 4
end

-- Функция следования вдоль правой стены по правилу правой руки.
local function followRightWall()
    while true do
        local x, y = startX, startY

        if x == endX and y == endY then
            print("Maze solved!")
            break
        end

        -- Проверяет доступные пути вправо, вперед и влево.
        turtle.turnRight()
        local rightBlocked = turtle.detect()  -- Проверяет новое направление вперед
        turtle.turnLeft()  -- Возвращается в исходное направление
        local frontBlocked = turtle.detect()
        turtle.turnLeft()  -- Поворачивает налево, чтобы проверить левое направление.
        local leftBlocked = turtle.detect()  -- Проверяет новое направление вперед
        turtle.turnRight()  -- Возвращается в исходное направление

        if not rightBlocked then
            turnRight()
            moveForward()
        elseif not frontBlocked then
            moveForward()
        elseif not leftBlocked then
            turtle.turnLeft()
            moveForward()
        else
            -- Если все пути заблокированы, разворачивается
            turnAround()
            moveForward()
        end
    end
end

-- Вызывает функцию, чтобы начать решение лабиринта
followRightWall()
