FROM openresty/openresty:alpine

RUN apk add --no-cache perl && opm get cdbattags/lua-resty-jwt
