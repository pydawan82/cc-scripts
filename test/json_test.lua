require('debug.inspect')

local function test()
    local f = io.open('./test/test.json', 'r')
    local s, t = pcall(json.parse, f)

    repr(t)
end

test()
