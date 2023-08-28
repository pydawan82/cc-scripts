local P = {}
cmap = P

local color_scale = {
    colors.blue,
    colors.cyan,
    colors.lightBlue,
    colors.lime,
    colors.yellow,
    colors.orange,
    colors.red,
}

function P.colormap(value, min, max)
    min, max = max and min or 0, max or min or 1

    value = math.min(value, max)
    value = math.max(value, min)

    local index = math.floor((value - min) / (max - min) * (#color_scale - 1))

    return color_scale[index + 1]
end

return cmap
