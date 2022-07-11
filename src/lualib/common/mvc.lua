
local uri = ngx.var.uri
-- 如果是首页
if uri == "" or uri == "/" then
    local res = ngx.location.capture("/index.html", {})
    ngx.say(res.body)
    return
end

print(uri .. "over")
local it, err = ngx.re.gmatch(uri, "([a-zA-Z0-9_]+)(?=/?)")
local path_tab = {}
while true do
    local m, err = it()
    if err then
        ngx.log(ngx.ERR, "error: ", err)
        return
    end
    if not m then
        -- no match found (any more)
        break
    end
    -- found a match
    path_tab[#path_tab + 1] = m[1]
    ngx.log(ngx.INFO, m[1])
end

local is_debug = true       -- 调试阶段，会输出错误信息到页面上

local moduleName = path_tab[1]     -- 模块名
local method = path_tab[2]         -- 方法名

if not method then
    method = "index"        -- 默认访问index方法
else
    method = ngx.re.gsub(method, "-", "_")    
end

-- 控制器默认在web包下面
local prefix = "web."
local path = prefix .. moduleName

-- 尝试引入模块，不存在则报错
local ret, ctrl, err = pcall(require, path)

if ret == false then
    if is_debug then
        ngx.status = 404
        ngx.say("<p style='font-size: 50px'>Error: <span style='color:red'>" .. ctrl .. "</span> module not found !</p>")
    end
    ngx.exit(404)
end

-- 尝试获取模块方法，不存在则报错
local req_method = ctrl[method]

if req_method == nil then
    if is_debug then
        ngx.status = 404
        ngx.say("<p style='font-size: 50px'>Error: <span style='color:red'>" .. method .. "()</span> method not found in <span style='color:red'>" .. moduleName .. "</span> lua module !</p>")
    end
    ngx.exit(404)
end

-- 执行模块方法，报错则显示错误信息，所见即所得，可以追踪lua报错行数
ret, err = pcall(req_method)

if ret == false then
    if is_debug then
        ngx.status = 404
        ngx.say("<p style='font-size: 50px'>Error: <span style='color:red'>" .. err .. "</span></p>")
    else
        ngx.exit(500)
    end
end


