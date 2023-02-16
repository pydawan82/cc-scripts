function assert_type(value, ...)
    local types = {...}
    tpe = type(value)

    for _, t in ipairs(types) do
        if tpe == t then
            return
        end
    end

    local msg = "Expected type " .. table.concat(types, " or ") .. ", got " .. tpe
    error(msg, 2)
end