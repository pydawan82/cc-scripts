local INDENT = 2

local function contains(xs, x)
    for _, v in ipairs(xs) do
        if v == x then
            return true
        end
    end

    return false
end

---
---@param t table
---@param depth? integer
---@param visited? table
local function repr_table(t, depth, visited)
    depth = depth or 0
    visited = visited or {}

    if contains(visited, t) then
	io.write('...')
	return
    else
	table.insert(visited, t)
    end

    io.write('{')
    
    once = true
    for k, v in pairs(t) do
        if once then
            once = false
            io.write('\n')    
        end

        if type(v) == 'table' then
            io.write(string.rep(' ', depth + INDENT) .. k .. ' = ')
            repr_table(v, depth + INDENT, visited)
            io.write(',\n')
        else
            io.write(string.rep(' ', depth + INDENT) .. k .. ' = ')
            repr(v) io.write(',\n')
        end
    end
    
    if not once then
        io.write(string.rep(' ', depth))
    end

    io.write('}')
end


function repr(x)
    if type(x) == 'string' then
        return io.write("\"" .. x .. "\"")
    elseif type(x) == 'table' then
        return repr_table(x)
    else
        return io.write(x)
    end
end
