-- JSON Parser

local P = {}
json = P

local parse_object
local parse_array

local function is_whitespace(char)
    return char == ' ' or char == '\t' or char == '\n' or char == '\r'
end

local function next_non_ws(file)
    char = file:read(1)
    while is_whitespace(char) do
        char = file:read(1)
    end
    return char
end

---@param file file*
---@param char string
---@return string
local function parse_string(file, char)
    local string = {}
    local pos = 1

    char = file:read(1)
    while char ~= '"' do
        if char == '\\' then
            char = file:read(1)
            if char == 'b' then
                char = '\b'
            elseif char == 'f' then
                char = '\f'
            elseif char == 'n' then
                char = '\n'
            elseif char == 'r' then
                char = '\r'
            elseif char == 't' then
                char = '\t'
            elseif char == '"' then
                char = '"'
            elseif char == '\\' then
                char = '\\'
            else
                error('Unexpected escape character: \\' .. char)
            end
        end
        string[pos] = char
        pos = pos + 1
        char = file:read(1)
    end

    return table.concat(string)
end

---@param file file*
---@param char string
---@return number
local function parse_number(file, char)
    local value = {}
    local pos = 1

    char = char or file:read(1)
    while char ~= ',' and char ~= '}' and not is_whitespace(char) do
        value[pos] = char
        pos = pos + 1
        char = file:read(1)
    end

    return tonumber(table.concat(value)), char
end

---@param file file*
---@param char string
---@return any
local function parse_value(file, char)
    char = char or next_non_ws(file)
    if char == '"' then
        return parse_string(file)
    elseif char == '[' then
        return P.parse_array(file)
    elseif char == '{' then
        return P.parse_object(file)
    elseif char == '-' or char == '.' or char >= '0' and char <= '9' then
        return parse_number(file)
    elseif char == 't' then
        local rest = file:read(3)
        if rest ~= 'rue' then
            error('Unexpected character: ' .. char .. rest)
        end
        return true
    elseif char == 'f' then
        local rest = file:read(4)
        if rest ~= 'alse' then
            error('Unexpected character: ' .. char .. rest)
        end
        return false
    elseif char == 'n' then
        local rest = file:read(3)
        if rest ~= 'ull' then
            error('Unexpected character: ' .. char .. rest)
        end
        return nil
    else
        error('Unexpected character: ' .. char)
    end
end

---@param file file*
---@param char string
---@return [any]
function P.parse_array(file, char)
    local array = {}
    local pos = 1

    char = next_non_ws(file)
    if char == ']' then
        return array
    end

    while true do
        array[pos], char = parse_value(file, char)
        pos = pos + 1

        if not char or is_whitespace(char) then
            char = next_non_ws(file)
        end

        if char == ']' then
            return array
        end

        if char ~= ',' then
            error('Expected a comma got ' .. char .. ' instead')
        end

        char = next_non_ws(file)
    end
end

---@param file file*
---@param char string
---@return table
function P.parse_object(file, char)
    local object = {}

    char = next_non_ws(file)
    local value
    if char == '}' then
        return object
    end

    while true do
        if char ~= '"' then
            error('Expected a string got "' .. char .. '" instead')
        end

        local key = parse_string(file)

        char = next_non_ws(file)
        if char ~= ':' then
            error('Expected a colon')
        end

        value, char = parse_value(file)

        object[key] = value

        if not char or is_whitespace(char) then
            char = next_non_ws(file)
        end

        if char == '}' then
            return object
        end

        if char ~= ',' then
            error('Expected a comma got ' .. char .. ' instead')
        end

        char = next_non_ws(file)
    end
end

function P.parse(file)
    return parse_value(file)
end

return json
