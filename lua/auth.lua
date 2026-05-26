local jwt = require "resty.jwt"
local cjson = require "cjson"

local function deny(reason)
    ngx.status = 401
    ngx.header["Content-Type"] = "application/json"
    ngx.header["WWW-Authenticate"] = 'Bearer realm="api"'
    ngx.say(cjson.encode({ error = reason }))
    return ngx.exit(401)
end

local secret = os.getenv("JWT_SECRET")
if not secret or secret == "" then
    ngx.log(ngx.ERR, "JWT_SECRET is not set")
    return deny("server configuration error")
end

local auth_header = ngx.var.http_authorization
if not auth_header then
    return deny("authorization header required")
end

local token = auth_header:match("^Bearer%s+(.+)$")
if not token then
    return deny("bearer token required")
end

local obj = jwt:verify(secret, token)

if not obj.verified then
    return deny(obj.reason or "invalid token")
end
