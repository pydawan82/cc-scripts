local P = {}
functools = P

function P.map(func, map)
    local result = {}

    for k, v in pairs(map) do
        result[k] = func(v)
    end

    return result
end

function P.filter(func, map)
    local result = {}

    for k, v in pairs(map) do
        if func(v) then
            result[k] = v
        end
    end

    return result
end

function P.reduce(func, map, initial)
    local result = initial

    for k, v in pairs(map) do
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

return functools
