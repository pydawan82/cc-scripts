local P = {}
base64 = P

function P.decode(str)
    local result = {}
    local pos = 1

    while string.byte(str, -1) == 10 do
        str = string.sub(str, 1, -2)
    end


    while pos <= #str do
        local sextet = 0
        local i = 0
        while i < 4 do
            local char = string.byte(str, pos)

            sextet = sextet * 64
            if char >= 65 and char <= 90 then
                sextet = sextet + char - 65
            elseif char >= 97 and char <= 122 then
                sextet = sextet + char - 71
            elseif char >= 48 and char <= 57 then
                sextet = sextet + char + 4
            elseif char == 43 then
                sextet = sextet + 62
            elseif char == 47 then
                sextet = sextet + 63
            elseif char == 61 then
            elseif char == 10 then
                i = i - 1
            else
                error('Invalid character: ' .. string.char(char) .. ' (' .. char .. ')')
            end

            i = i + 1
            pos = pos + 1
        end

        i = 0

        local octet1 = math.floor(sextet / 65536)
        local octet2 = math.floor(sextet / 256) % 256
        local octet3 = sextet % 256

        table.insert(result, string.char(octet1, octet2, octet3))
    end

    while string.byte(result[#result], -1) == 0 do
        result[#result] = string.sub(result[#result], 1, -2)
    end

    return table.concat(result)
end

return P
