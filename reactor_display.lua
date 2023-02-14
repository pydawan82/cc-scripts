require('printf')
cmap = require('cmap')

reactor = peripheral.wrap('left')
monitor = peripheral.wrap('right')

local function clear()
    term.clear()
    term.setCursorPos(1, 1)
end

local function display(fuel, max_fuel, rod_level, temp)
    term.setTextColor(cmap.colormap(fuel_level, 0, 10000))
    printf('Fuel: %.1f/%.1fB', fuel_level, max_fuel)

    term.setTextColor(cmap.colormap(rod_level, 0, 100))
    printf('Control Rod: %d%%', rod_level)

    term.setTextColor(cmap.colormap(temp, 0, 4000))
    printf('Temperature: %dK', temp)
end


local function main()
    while true do
        local fuel_level = reactor.fuelTank().level() / 1000
        local rod_level = reactor.getControlRod(0).level()
        local temp = reactor.fuelTemperature()

        clear()
        display(fuel_level, rod_level, temp)

        sleep(1)
    end
end

main()