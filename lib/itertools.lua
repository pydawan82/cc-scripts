local P = {}
itertools = P

---@generic T
---@alias iterator fun(): T

---@generic T
---@alias iterable iterator<T>|[T]

--- returns an iterable
---@generic T
---@param it iterable<T>
---@return iterator<T>
function P.iter(it)
    if type(it) == 'function' then
        return it
    elseif type(it) == 'table' then
        if it.__iter__ ~= nil then
            return it.__iter__
        else
            return P.iter_list(it)
        end
    else
        error(it .. 'is not iterable')
    end
end

---comment
---@generic T
---@param it [T]
---@return iterator<T>
function P.iter_list(it)
    local i = 0

    return function()
        i = i + 1
        return it[i]
    end
end


---
---@generic T
---@param it iterable<T>
---@return [T]
function P.list(it)
    local xs = {}

    for x in P.iter(it) do
        table.insert(xs, x)
    end

    return xs
end

---comment
---@generic T
---@param it iterator<T>
---@return fun(): integer, T
function enumerate(it)
    it = P.iter(it)
    local i = 0

    return function()
        i = i + 1
        x = it()

        if x == nil then
            return nil
        end

        return i, x
    end
end

---
---@generic T
---@param ... T
---@return iterator<T>
function P.zip(...)
    local its = {}

    for it in P.iter_list({...}) do
        table.insert(its, P.iter(it))
    end

    return function()
        values = {}

        for it in P.iter_list(its) do
            val = it()

            if val == nil then
                return nil
            end

            table.insert(values, val)
        end

        return table.unpack(values)
    end
end

return itertools
