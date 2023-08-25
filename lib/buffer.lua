local P = {}
buffer = P

local c_meta = {}

function P.new()
    local buffer = {
        data = {},
        len = 0
    }

    return setmetatable(buffer, c_meta)
end

function c_meta.__index(buffer, key)
    if type(key) == 'number' then
        return buffer.data[key]
    else
        return c_meta[key]
    end
end

function c_meta.__newindex(buffer, key, value)
    if type(key) == 'number' then
        buffer.data[key] = value
    else
        c_meta[key] = value
    end
end

function c_meta.__len(buffer)
    return buffer.len
end

function c_meta.__tostring(buffer)
    return table.concat(buffer.data)
end

function c_meta:write(str)
    self.len = self.len + #str
    table.insert(self.data, str)
end
