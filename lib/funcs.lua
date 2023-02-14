local P = {}
funcs = P

function P.sigmoid(x)
    return 1 / (1 + math.exp(-x))
end

return funcs