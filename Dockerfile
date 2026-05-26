FROM openresty/openresty:alpine

RUN apk add --no-cache git && \
    git clone --depth 1 https://github.com/cdbattags/lua-resty-jwt.git /tmp/lua-resty-jwt && \
    git clone --depth 1 https://github.com/jkeys089/lua-resty-hmac.git /tmp/lua-resty-hmac && \
    cp -r /tmp/lua-resty-jwt/lib/resty/* /usr/local/openresty/lualib/resty/ && \
    cp -r /tmp/lua-resty-hmac/lib/resty/* /usr/local/openresty/lualib/resty/ && \
    rm -rf /tmp/lua-resty-jwt /tmp/lua-resty-hmac
