---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by panghuhu.
--- DateTime: 2022/6/25 15:06
---
---
local req = require "lualib.common.req"

local args = req.getArgs()

local name = args['name']

if name == nil or name == "" then
    name = "guest"
end

ngx.say("<p>hello " .. name .. "!</p>")
