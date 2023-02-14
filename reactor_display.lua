require('printf')
cmap = require('cmap')

reactor = peripheral.wrap('left')
monitor = peripheral.wrap('right')

local function clear()
    term.clear()
    term.setCursorPos(1, 1)
end

local function display(fuel_level, fuel_capcity, rod_level, temp)
    term.setTextColor(cmap.colormap(fuel_level, fuel_capcity))
    printf('Fuel: %.1f/%.1fB', fuel_level, fuel_capcity)

    term.setTextColor(cmap.colormap(rod_level, 100))
    printf('Control Rod: %3d%%', math.floor(rod_level))

    term.setTextColor(cmap.colormap(temp, 4000))
    printf('Temperature: %4dK', math.floor(temp))
end


local function main()
    while true do
        local fuel_level = reactor.fuelTank().level() / 1000
        local fuel_capacity = reactor.fuelTank().capacity() / 1000
        local rod_level = reactor.getControlRod(0).level()
        local temp = reactor.fuelTemperature()

        clear()
        display(fuel_level, fuel_capacity, rod_level, temp)

        sleep(1)
    end
end

main()