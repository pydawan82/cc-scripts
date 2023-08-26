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
