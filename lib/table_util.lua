P = {}
table_util = P

function P.merge(t1, t2)
    for k,v in pairs(t2) do
        t1[k] = v
    end
end

return table_util