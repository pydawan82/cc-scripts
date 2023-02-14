P = {}
term = P

function P.redirect(monitor)
    return
end

function P.clear()
    return io.write('\x1b[2J')
end

function P.setCursorPos(x, y)
    return io.write('\x1b[' .. y .. ';' .. x .. 'H')
end

function P.setBackgroundColor(color)
    return io.write('\x1b[48;5;' .. color .. 'm')
end

function P.setTextColor(color)
    return io.write('\x1b[38;5;' .. color .. 'm')
end

return term