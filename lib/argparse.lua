local P = {}
argparse = P

local meta = {}

function P.new()
    local self = setmetatable({}, {__index=meta})
    self.npos = 0
    self.args = {}
    self.kwargs = {}
    return self
end

local POS = 1
local KW = 2

-- Parse an argument name, returning the type and the name.
-- '--name' -> KW, 'name'
-- 'name' -> POS, 'name
-- 'my-name' -> POS, 'my-name'
local function parse_name(argument)
    if argument:sub(1, 2) == '--' then
        return KW, argument:sub(3)
    elseif argument:sub(1, 1) == '-' then
        return KW, argument:sub(2)
    else
        return POS, argument
    end
end

local function parse_short(argument)
    if argument == nil then
        return nil
    end

    if argument:sub(1, 1) == '-' then
        return argument:sub(2)
    else
        return nil
    end
end

function meta:add_argument(argument, help, short)
    local tpe, name = parse_name(argument)
    local short_name = parse_short(short)
    local arg = {name=name, help=help, short=short_name}
    if tpe == POS then
        self.npos = self.npos + 1
        self.args[self.npos] = arg
    else
        self.kwargs[name] = arg
        if short then
            self.kwargs[short_name] = arg
        end
    end

    return self
end

function meta:help()
    print("Usage: " .. arg[0] .. " [options]")

    for name, arg in pairs(self.args) do
        line = "  " .. name
        if arg.short then
            line = line .. ", " .. arg.short
        end
        if arg.help then
            line = line .. " " .. arg.help
        end
        print(line)
    end

    for name, arg in pairs(self.kwargs) do
        line = "  --" .. name
        if arg.short then
            line = line .. ", -" .. arg.short
        end
        if arg.help then
            line = line .. " " .. arg.help
        end
        print(line)
    end
end

function meta:parse(...)
    local args = {}
    local kwargs = {}
    local i = 1
    local npos = 0
    while i <= #arg do
        local argument = arg[i]
        local tpe, name = parse_name(argument)
        if tpe == POS then
            npos = npos + 1
            local argt = self.args[npos]
            if argt == nil then
                print("Unknown argument: " .. name)
                self:help()
                os.exit(1)
            end
            args[argt.name] = argument
        else
            local argt = self.kwargs[name]
            if argt == nil then
                print("Unknown argument: " .. name)
                self:help()
                os.exit(1)
            end
            i = i + 1
            kwargs[argt.name] = arg[i]
        end
        i = i + 1
    end
    return args, kwargs
end

return argparse