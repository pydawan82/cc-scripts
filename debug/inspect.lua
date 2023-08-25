local INDENT = 2
function inspect_table(t, depth)
    depth = depth or 0
    -- Prints a table in a human-readable format
    io.write('{\n')
    for k, v in pairs(t) do
        if type(v) == 'table' then
            io.write(string.rep(' ', depth + INDENT) .. k .. ' = ')
            inspect_table(v, depth + INDENT)
            io.write(',\n')
        else
            io.write(string.rep(' ', depth + INDENT) .. k .. ' = ' .. tostring(v) .. ',\n')
        end
    end
    io.write(string.rep(' ', depth) .. '}')
end
