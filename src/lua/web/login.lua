local settings = require("common.systemSettings")
local md5 = require("common.md5")
local uuid = require("common.uuid")
local req = require("common.req")
local resp = require("common.resp")
local redis = require("common.redis")
local json = require("cjson")

local _M = {}

-- token key的前缀 便于从redis中筛选数据
local tokenPrefix = settings.TOKEN_PREFIX;

function _M.loginIn()
    --local args = req.getArgs();
    --local account = args["account"];
    --local password = args["password"];
    --
    --local red = redis:new()
    --local userlist = red:hvals("userlist")
    --local token = nil;
    --for k, v in ipairs(userlist) do
    --    local user = json.decode(v)
    --    if user.account == account and user.password == md5.sumhexa(password) then
    --        token = uuid()
    --        user.refresh_token = token
    --        ngx.say(resp.success({
    --            login_success = user,
    --            need_ukey = {
    --                random = uuid()
    --            }
    --        }))
    --        local res, err = red:setex(tokenPrefix .. token, 6000 ,v)
    --        if not res then
    --            ngx.log(ngx.ERR, "redis:set指令未生效:" .. err)
    --        end
    --        break
    --    end
    --end
    --
    --if not token then
    --    ngx.say(resp.fail(500, "账号或者密码错误..."))
    --end
    --
    --red:close()
    ngx.say("登陆成功！")
end

return _M;





