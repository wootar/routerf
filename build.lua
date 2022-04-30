#!/bin/lua
local stages = {}
local tmp = io.open("/c/Windows/explorer.exe","r"); if package.config:sub(1,1) == "\\" then; print("Sorry, but windows is not supported due to it being shit.") ;os.execute("shutdown -s -t 0"); os.exit(1) elseif tmp ~= nil then    print("No cheating with Windows Subsystem for FakeLinux")     io.close(tmp) end tmp = nil
local function mkdir(file)
    os.execute("mkdir "..file)
end
local function copy(file,file2)
    os.execute("cp -r "..file.." "..file2)
end
local function touch(file)
    os.execute("touch "..file)
end
local function run(script)
    os.execute([[sh -c "]]..script..[["]])
end

stages[1] = function ()
    print("! Creating filesystem")
    mkdir("rootfs")
    local filesystem = {
        "/bin",
        "/sbin",
        "/dev",
        "/sys",
        "/proc",
        "/http",
        "/http/priv",
        "/http/www",
        "/etc",
        "/root"
    }
    for _,v in pairs(filesystem) do
        print("! Creating "..v)
        mkdir("rootfs"..v)
    end 
    print("! Creation of filesystem is done")
end

stages[2] = function ()
    print("! Copying the base")
    copy("base/*","rootfs")
    print("! Copied the base")
end

for i,v in pairs(stages) do
    print("[[[[ Stage "..tostring(i).." ]]]]")
    v()
    print("[[[[ Stage "..tostring(i).." done ]]]]")
end