#!/bin/lua
local function cat(file)
    local file_open = io.open(file,"r")
    return file_open:read("a")
end

cat("/http/priv/ui.html")