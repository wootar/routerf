#!/bin/lua

print("Content-type: text/html")
print("")
local vars = {}
local tmp = os.getenv("QUERY_STRING")
-- tmp = tmp:gsub("&","\n")
-- tmp = tmp:gsub("&"," ")
for i,v in tmp:gmatch("(%w+)=(%w+)") do
    vars[i] = v
end

local index = io.open("/http/priv/ui.html","r")

local work = index:read("a")
local mem = io.popen("busybox dmesg","r")
work = work:gsub("<!--code-->","<p>"..mem:read("a").."</p>")
print(work)
index:close()
work = nil
mem:close()