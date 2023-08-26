function cls()
    term.clear()
    term.setCursorPos(1, 1)
end

function printf(fmt, ...)
    return print(fmt:format(...))
end
