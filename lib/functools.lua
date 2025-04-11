local P = {}
functools = P

local itertools = require('lib.itertools')

function P.map(f, it)
    return function ()
        local x = it()
        if x == nil then
            return nil
        else
            return f(x)
        end
    end
end

function P.filter(func, it)
    local result = {}

    it = itertools.iter(it)

    for k, v in pairs(it) do
        if func(v) then
            result[k] = v
        end
    end

    return result
end

function P.reduce(func, map, initial)
    local result = initial

    for v in map do
        if result == nil then
            result = v
        else
            result = func(result, v)
        end
    end

    return result
end

function P.sum(map)
    return P.reduce(function(a, b) return a + b end, map, 0)
end

function P.all(pred, map)
    return P.reduce(function (l, r) return l and r end, P.map(pred, map), true)
end

function P.any(pred, map)
    return P.reduce(function (l, r) return l or r end, P.map(pred, map), false)
end

return functools
