files = fs.list("/")
for _, file in ipairs(files) do
    if file == "rom" or file == "disk" then
        print("Skipping " .. file)
    else
        print("Deleting " .. file)
        fs.delete(file)
    end
end
