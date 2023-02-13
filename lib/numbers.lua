local P = {}
numbers = P

local prefixes = {
    [-5] = 'f'
    [-4] = 'p',
    [-3] = 'n',
    [-2] = 'u',
    [-1] = 'm',
    [0] = '',
    [1] = 'k',
    [2] = 'M',
    [3] = 'G',
    [4] = 'T',
    [5] = 'P',
    [6] = 'E',
    [7] = 'Z',
    [8] = 'Y',
    min = -5,
    max = 8
}

local function min(a, b) return a < b and a or b end
local function max(a, b) return a > b and a or b end

local function get_prefix(number)
    scale = math.floor(math.log(number)/math.log(1000))
    scale = max(prefixes.min, min(prefixes.max, scale))


end

function P.to_prefix(number)
    scale, prefix = get_prefix(number)
    return string.format("%.2f%s", number / scale, prefix)
end

return P