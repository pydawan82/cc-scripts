if #arg ~= 1 then
    print("Usage: cat <file>")
    os.exit(1)
end

file = arg[1]

for line in io.lines(file) do
    print(line)
end

