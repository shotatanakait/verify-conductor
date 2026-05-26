FROM openresty/openresty:alpine

RUN apk add --no-cache perl && /usr/local/openresty/bin/opm get cdbattags/lua-resty-jwt
