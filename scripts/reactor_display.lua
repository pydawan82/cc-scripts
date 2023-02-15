require('/lib/printf')
cmap = require('/lib/cmap')

reactor = peripheral.wrap('back')
monitor = peripheral.wrap('bottom')

local function clear()
    term.clear()
    term.setCursorPos(1, 1)
end

local function display(fuel_level, fuel_capcity, rod_level, temp, steam)
    term.setTextColor(cmap.colormap(fuel_level, fuel_capcity))
    printf('Fuel: %.1f/%.1fB', fuel_level, fuel_capcity)

    term.setTextColor(cmap.colormap(rod_level, 100))
    printf('Control Rod: %3d%%', math.floor(rod_level))

    term.setTextColor(cmap.colormap(temp, 3500))
    printf('Temperature: %4dK', math.floor(temp))

    term.setTextColor(cmap.colormap(steam, 80))
    printf('Steam: %.1fB/t', steam)
end

local function main()
    term.redirect(monitor)
    while true do
        local fuel_level = reactor.fuelTank().fuel() / 1000
        local fuel_capacity = reactor.fuelTank().capacity() / 1000
        local rod_level = reactor.getControlRod(0).level()
        local temp = reactor.fuelTemperature()
        local steam = reactor.coolantTank().transitionedLastTick() / 1000
        clear()
        display(fuel_level, fuel_capacity, rod_level, temp, steam)

        sleep(1)
    end
end

main()
