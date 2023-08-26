json = require('lib/json')
require('debug/inspect')

local function test()
    f = io.open('test.json', 'r')
    local s, t = pcall(json.parse, f)

    inspect_table(t)
end

test()
