local P = {}
setuptools = P

function P.setup(scripts, libs, startup)
    fs.makeDir('lib')
    for _, lib in ipairs(libs) do
        libname = lib .. '.lua'
        fs.copy('disk/lib/' .. lib, 'lib/' .. lib)
    end

    fs.makeDir('scripts')
    for _, script in ipairs(scripts) do
        scriptname = script .. '.lua'
        fs.copy('disk/scripts/' .. script, 'scripts/' .. script)
    end

    f = fs.open('startup.lua', 'w')
    f:write('shell.run(\'scripts/' .. startup .. '\')')
    f:close()
end

return P
