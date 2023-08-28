local ITEM = 6

local NONE = 0
local INPUT = 1
local INPUT_1 = 2
local INPUT_2 = 3
local OUTPUT = 4
local EXTRA = 9

local FRONT = 0
local LEFT = 1
local RIGHT = 2
local BACK = 3
local TOP = 4
local BOTTOM = 5

local function select(name)
    for i = 1, 16 do
        if turtle.getItemDetail(i).name == name then
            select(i)
            return
        end
    end

    error('Item not found')
end

local function forward()
    assert(turtle.forward(), "Failed to move forward")
end

local function back()
    assert(turtle.back(), "Failed to move back")
end

local function placeDown()
    assert(turtle.placeDown(), "Failed to place block")
end

local function turnRight()
    assert(turtle.turnRight(), "Failed to turn right")
end

local function turnLeft()
    assert(turtle.turnLeft(), "Failed to turn left")
end

local function wrap(side)
    sleep(0.1)
    return assert(peripheral.wrap(side), "No peripheral on " .. side)
end

local function defaultConfig(machine)
    machine.setEjecting(ITEM, true)
end

local function configCrusher(crusher)
    defaultConfig(crusher)
    crusher.setMode(ITEM, RIGHT, NONE)
    crusher.setMode(ITEM, BACK, OUTPUT)
end

local function configFA(fa)
    defaultConfig(fa)
    fa.setMode(ITEM, TOP, EXTRA)
    select('mekanism:crafting_formula')
    assert(turtle.dropDown(), 'Error while trying to put formula')
    fa.setAutoMode(true)
    fa.setStockControl(true)
end

local function setup()
    forward()
    turnLeft()
    turnLeft()
    select('mekanism:crusher')
    placeDown()
    local machine = wrap("bottom")
    defaultConfig(machine)
    turnRight()
    forward()
    turnLeft()
    select('mekanism:crusher')
    placeDown()
    local machine = wrap("bottom")
    defaultConfig(machine)
    turnRight()
    forward()
    turnLeft()
    select('mekanism:formulaic_assemblicator')
    placeDown()
    local machine = wrap("bottom")
    configFA(machine)
    turnRight()
    turnRight()
    forward()
    turnLeft()
    turnLeft()
    select('mekanism:crusher')
    placeDown()
    local machine = wrap("bottom")
    configCrusher(machine)
    turnLeft()
    forward()
    turnRight()
    select('mekanism:enrichment_chamber')
    placeDown()
    local machine = wrap("bottom")
    defaultConfig(machine)
    turnLeft()
    forward()
    turnRight()
    select('mekanism:crusher')
    placeDown()
    local machine = wrap("bottom")
    defaultConfig(machine)
    turnLeft()
    turnLeft()
end

local function transfer()
    ec = wrap("bottom")
    c = wrap("left")

    for i = 1, 7 do
        s = ec.pushItems(peripheral.getName(c), i)
        assert(s, 'Failed to pull item')
    end
end

local function get_item(from, max)
    for i = from, max do
        if turtle.getItemDetail(i).name == name then
            return i
        end
    end

    error('Item not found')
end

local function get_items()
    for i = 1, 7 do
        s = turtle.suck()
        assert(s == 1, 'Failed to suck')
    end
end

local function go(n)
    d = 2 * n + 1
    for i = 1, d do
        forward()
    end
end

local function comeb(n)
    d = 2 * n + 1
    for i = 1, d do
        back()
    end
end

local function main()
    for i = 0, 11 do
        transfer()
        get_items()
        go(i)
        setup()
        comeb(i)
    end
end

main()
