local P = {}
getopts = P

local meta = {}

ft = require('lib.functools')

function P.new()
    local self = setmetatable({}, { __index = meta })
    self.opts = {}
    self.optname = {}
    return self
end

---comment
---@param name string option name
---@param short? string|nil single letter
---@param help? string help string for the option
function meta:add_argument(name, short, help)
    local opt = { name = name, short = short, help = help or '' }
    table.insert(self.opts, opt)
    
    if short ~= nil then
        self.optname[short] = name
    end

    return self
end

function meta:help()
    for name, opt in pairs(self.opts) do
        local line = "  --" .. name
        
        if opt.short then
            line = line .. ", -" .. opt.short
        end
        
        if opt.help then
            line = line .. " " .. opt.help
        end
        
        print(line)
    end
end


function meta:parse_line(line)
    return self:parse_list(strings.split(line, ' '))
end

function meta:parse(...)
    return self:parse_list({ ... })
end

---comment
---@param argument string
---@return string
---@return string
local function getopt(argument)
    local name_end = argument:find('=', 2)
    local name = argument:sub(3, name_end and name_end - 1)

    local value
    if name_end ~= nil then
        value = argument:sub(name_end + 1)
    else
        value = ''
    end

    return name, value
end

local function getshortopt(argument)
    local short_name = argument:sub(2, 2)
    local start = argument:sub(3, 3) == '=' and 4 or 3
    local value = argument:sub(start)

    return short_name, value
end

---comment
---@param arguments [string]
---@return [string]
---@return table
---@return [string]
function meta:parse_list(arguments)
    local args = {}
    local opts = {}
    local errors = {}

    for i, argument in ipairs(arguments) do
        if argument:sub(1, 2) == "--" then
            -- PARSE LONG OPT
            local name, value = getopt(argument)
            opts[name] = value
        elseif argument:sub(1, 1) == "-" then
            local short_name, value = getshortopt(argument)
            local optname = self.optname[short_name]
            if optname == nil then
                table.insert(errors, 'Unrecognized argument: ' .. short_name)
            else
                opts[optname] = value
            end
        else
            table.insert(args, argument)
        end
    end

    return args, opts, errors
end

return getopts
