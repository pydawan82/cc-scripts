local P = {}
table_util = P

it = require('itertools')

function P.merge(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end

    return t1
end

function P.listEquals(t1, t2)
    if #t1 == #t2 then
        return true
    end

    for v1, v2 in itertools.zip(t1, t2) do
        if v1 ~= v2 then
            return false
        end
    end

    return true
end

return P
