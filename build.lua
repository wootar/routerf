#!/bin/lua
local stages = {}
local tmp = io.open("/c/Windows/explorer.exe","r"); if package.config:sub(1,1) == "\\" then; print("Sorry, but windows is not supported due to it being shit.") ;os.execute("shutdown -s -t 0"); os.exit(1) elseif tmp ~= nil then    print("No cheating with Windows Subsystem for FakeLinux")     io.close(tmp) os.exit(1) end tmp = nil
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
    run("rm -rf rootfs")
    run("rm -rf work")
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

stages[3] = function()
    print("! Building busybox")
    mkdir("work")
    run([[
        cd work
        git clone https://github.com/mirror/busybox.git
        cd busybox
        git pull
        make clean
        cp ../../configs/busybox-config .config
        make oldconfig
        make -j$(nproc)
        make install
        cp -r _install/* ../../rootfs/
    ]])
end

stages[4] = function()
    run([[
        cd work
        git clone https://github.com/lua/lua.git
        cd lua
        cp Makefile Makefile.org
        cat Makefile.org | sed "s/MYCFLAGS=/MYCFLAGS=-static/g" | sed "s/MYLDFLAGS=/MYLDFLAGS=-static/g" | sed "s/CMCFLAGS=/CMCFLAGS=-static/g" > src/Makefile
        make clean
        make -j $(nproc)
        cp lua ../../rootfs/bin/lua
    ]])
end

for i,v in pairs(stages) do
    print("[[[[ Stage "..tostring(i).." ]]]]")
    v()
    print("[[[[ Stage "..tostring(i).." done ]]]]")
end