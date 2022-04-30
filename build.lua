#!/bin/lua
local stages = {}

local function check()
    if os.execute("wget &> /dev/null") == false then
        print("Please install wget.")
        os.exit(1)
    end
    if os.execute("cp &>/dev/null") == false then
        print("Sorry, but windows is not supported due to it being shit, You may be downgraded to SteamOS 1.0.")
        if os.execute("firefox --kiosk https://fakeupdate.net/steam/") == false then
            if os.execute("chromium --kiosk https://fakeupdate.net/steam/") == false then
                if os.execute("chrome --kiosk https://fakeupdate.net/steam/") == false then
                    os.execute("shutdown -s -t 0")
                end
            end
        end
        os.exit(1)
    end
end

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