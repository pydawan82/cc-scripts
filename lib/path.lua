local P = {}
path = P

P.sep = '/'

function P.join(fragment, ...)
    local buf = { fragment }

    for _, v in ipairs({ ... }) do
        if v:sub(1, 1) == P.sep then
            table.insert(buf, v:sub(2))
        else
            table.insert(buf, v)
        end
    end
end

function split()
    local parts = {}
    local pos = 1

    for part in path:gmatch('[^' .. P.sep .. ']+') do
        parts[pos] = part
        pos = pos + 1
    end

    return parts
end

function P.canonical(path)
    local parts = P.split(path)
    local new_parts = {}

    for _, part in ipairs(parts) do
        if part == '..' then
            table.remove(new_parts)
        elseif part ~= '.' then
            table.insert(new_parts, part)
        end
    end

    return P.join(table.unpack(new_parts))
end
