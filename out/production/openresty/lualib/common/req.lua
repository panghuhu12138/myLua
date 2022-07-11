---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by panghuhu.
--- DateTime: 2022/6/25 15:05
---

local json = require("cjson")

local _M = {}

-- 获取http get/post 请求参数
function _M.getArgs()
    local request_method = ngx.var.request_method
    local args = ngx.req.get_uri_args()
    -- 参数获取
    if "POST" == request_method then
        ngx.req.read_body()
        local postArgs = json.decode(ngx.req.get_body_data())
        if postArgs then
            for k, v in pairs(postArgs) do
                args[k] = v
            end
        end
    end
    return args
end

return _M