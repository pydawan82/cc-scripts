P = {}
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
color_scale.n = #color_scale

function P.colormap(value, min, max)
    max = max or min or 1
    min = max and min or 0

    value = math.min(value, max)
    value = math.max(value, min)

    local index = math.floor((value - min) / (max - min) * #color_scale)

    return color_scale[index + 1]
end

return cmap