test_dir = "test"
test_names = { "strings_test", "argparse_test", "base64_test" }

local function title(t)
    line = string.rep('-', t:len())
    print(line)
    print(t)
    print(line)
end

for _, test_name in ipairs(test_names) do
    test_path = test_dir .. '.' .. test_name
    title('Testing ' .. test_name)
    test = require(test_path)
    title(test_name .. ': Success!')
end