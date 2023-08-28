print("BOOM! This will delete all files on the computer. [y/n]")
local response = read()
if response:sub(1, 1) ~= "y" then
    print("Aborting")
    return
end

files = fs.list("/")
for _, file in ipairs(files) do
    if file == "rom" or file == "disk" then
        print("Skipping " .. file)
    else
        print("Deleting " .. file)
        fs.delete(file)
    end
end
