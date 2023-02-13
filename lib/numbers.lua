local P = {}
numbers = P

local prefixes = {
    {1e24, "Y"},
    {1e21, "Z"},
    {1e18, "E"},
    {1e15, "P"},
    {1e12, "T"},
    {1e9, "G"},
    {1e6, "M"},
    {1e3, "k"},
    {1, ""},
    {1e-3, "m"},
    {1e-6, "?"},
    {1e-9, "n"},
    {1e-12, "p"},
}

local function get_prefix(number)
    local last

    for i, prefix in ipairs(prefixes) do
        last = i
        if number >= prefix[1] then
            return unpack(prefix)
        end
    end

    return unpack(prefixes[last])
end

function P.to_prefix(number)
    scale, prefix = get_prefix(number)
    return string.format("%.2f%s", number / scale, prefix)
end

return P