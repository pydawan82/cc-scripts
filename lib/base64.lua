local P = {}
base64 = P

function P.decode(str)
    local result = {}
    local pos = 1

    while pos <= #str do
        local sextet = 0
        for i = 0, 3 do
            local char = string.byte(str, pos)
            pos = pos + 1
            if char >= 65 and char <= 90 then
                sextet = sextet * 2 + char - 65
            elseif char >= 97 and char <= 122 then
                sextet = sextet * 2 + char - 71
            elseif char >= 48 and char <= 57 then
                sextet = sextet * 2 + char + 4
            elseif char == 43 then
                sextet = sextet * 2 + 62
            elseif char == 47 then
                sextet = sextet * 2 + 63
            elseif char == 61 then
                sextet = sextet * 2
            else
                error('Invalid character')
            end
        end

        local octet1 = sextet // 256
        local octet2 = sextet // 16 % 16
        local octet3 = sextet % 16

        table.insert(result, string.char(octet1, octet2, octet3))
    end

    return table.concat(result)
end
