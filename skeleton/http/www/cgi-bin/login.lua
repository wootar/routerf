#!/bin/lua
local function cat(file)
    local file_open = io.open(file,"r")
    return file_open:read("a")
end

print("Content-type: text/html")
print("")
cat("/http/priv/ui.html")