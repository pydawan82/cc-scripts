P = {}
peripheral = P

p = {}


function P.wrap(side)
    return p
end

t_fuel_tank = 0

function p.fuelTank()
    return {
        fuel = function()
            t_fuel_tank = t_fuel_tank + 1
            return (math.sin(t_fuel_tank / 6) + 1) * 5000
        end,
        capacity = function()
            return 10000
        end
    }
end

local t_control_rod = 0
function p.getControlRod(index)
    return {
        level = function()
            t_control_rod = t_control_rod + 1
            return (math.sin(t_control_rod / 6) + 1) * 50
        end
    }
end

local t_fuel_temp = 0
function p.fuelTemperature()
    t_fuel_temp = t_fuel_temp + 1
    return (math.sin(t_fuel_temp / 6) + 1) * 2000
end

function p.coolTank()
    return {
        transitionedLastTick = function()
            return 1000
        end
    }
end

return peripheral
