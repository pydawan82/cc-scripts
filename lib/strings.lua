local P = {}
strings = P

function P.join(t, sep)
    sep = sep or ''

    local buf = {}

    for _, v in ipairs(t) do
        table.insert(buf, tostring(v))
        table.insert(buf, sep)
    end

    table.remove(buf)

    return table.concat(buf)
end

function P.tobuffer(str)
    local buffer = {}

    for i = 1, #str do
        buffer[i] = str:sub(i, i)
    end

    return buffer
end

---
---@param str string
---@param split string
---@param n? integer
function P.split(str, split, n)
    splits = {}
    start = 0

    while (n == nil or n > 0) and str do
        stop = str:find(split, start)
        
        if stop == nil then
            break
        end
        
        table.insert(splits, str:sub(start, stop - 1));
        start = stop + 1

        if n then n = n + 1 end
    end

    table.insert(splits, str:sub(start));

    return splits
end

return P