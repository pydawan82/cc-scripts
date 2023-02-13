local table_util = require("table_util")
local numbers = require("numbers")

local default_style = {
    size = 10,
    background_color = colors.black,
    load_color = colors.cyan,
    text_color = colors.yellow,

}

local function get_max_energy(battery)
    return 100
end

local function get_energy(battery)
    return 50
end

local function display_loading(ratio, text, style)
    style = table_util.merge(default_style, style or {})
    w, h = term.getSize()
    load_width = math.floor(ratio * w)

    term.setBackgroundColor(style.background_color)
    term.clear()

    paintutils.drawFilledBox(1, 1, load_width, h, style.load_color)

    if text then
        term.setTextColor(style.text_color)
        term.setCursorPos(1, h)

        term.setBackgroundColor(style.load_color)
        t1 = string.sub(text, 1, load_width)
        term.write(t1)

        term.setBackgroundColor(style.background_color)
        t2 = string.sub(text, load_width + 1, w)
        term.write(t2)
    end
end

local function main(m_side, b_side)
    local monitor = peripheral.wrap(m_side)
    local battery = peripheral.wrap(b_side)

    term.redirect(monitor)

    while true do
        local max_energy = get_max_energy(battery)
        local energy = get_energy(battery)
        local ratio = energy / max_energy
        local text = string.format("%d/%dRF", numbers.to_prefix(energy), numbers.to_prefix(max_energy))

        display_loading(ratio, text)
        sleep(1)
    end

end

main(...)