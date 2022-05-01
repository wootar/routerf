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

os.execute("cat /http/priv/ui.html")