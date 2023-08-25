json = require('json')
base64 = require('base64')

local SERVER = 'https://api.github.com'
local OWNER = 'pydawan82'
local REPO = 'cc-scripts'
local BRANCH = 'main'

HEADERS = {
    Authorization = 'Bearer '
}

local function get_file(url)
    response = http.get(url, HEADERS)
    blob = json.decode(response.readAll())
    return base64.decode(blob.content)
end

local function get_tree(sha)
    url = SERVER .. '/repos/' .. OWNER .. '/' .. REPO .. '/git/trees/' .. sha
    response = http.get(url, HEADERS)
    return json.decode(response.readAll())
end

local function for_each_blob(sha, path, callback)
    path = path or '/'
    tree = get_tree(sha)
    for _, entry in ipairs(tree.tree) do
        if entry.type == 'blob' then
            callback(path .. entry.path, entry.sha)
        elseif entry.type == 'tree' then
            for_each_blob(entry.sha, path .. entry.path .. '/', callback)
        end
    end
end

local INCLUDES = {
    'lib',
    'scripts'
}

local function save_blob(path, entry)
    local ok = false
    for _, include in ipairs(INCLUDES) do
        if path:sub(1, #include) == include then
            ok = true
            break
        end
    end

    if not ok then
        return
    end

    print('Saving ' .. path .. '/' .. entry.path)
    file = io.open(path .. '/' .. entry.path, 'w')
    file:write(get_file(entry.url))
    file:close()
end

local function main()
    for_each_blob(BRANCH, '/', save_blob)
end

main()
