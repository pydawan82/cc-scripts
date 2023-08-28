local P = {}
peripherals = P

local meta = {}

function meta.__index(t, k)
    t.__peripheral = t.__peripheral or peripheral.wrap(t.side)
    return t.__peripheral[k]
end

function P.wrap(side)
    local t = {
        __side = side,
        __peripheral = peripheral.wrap(side)
    }
    setmetatable(t, meta)

    return t
end

return P
