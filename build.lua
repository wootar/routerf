#!/bin/lua
local stages = {}

function mkdir(file)
    os.execute("mkdir "..file)
end
function touch(file)
    os.execute("touch "..file)
end
function run(script)
    os.execute([[sh -c "]]..script..[["]])
end

stages[1] = function ()
    print("! Creating filesystem")
    run([[
        echo TODO
        exit 0
    ]])
end

for i,v in pairs(stages) do
    print("[[[[ Stage "..tostring(i).." ]]]]")
    v()
    print("[[[[ Stage "..tostring(i).." done ]]]]")
end