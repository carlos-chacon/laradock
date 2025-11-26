#!/bin/bash

if [ ! -f /etc/nginx/ssl/default.crt ]; then
    openssl genrsa -out "/etc/nginx/ssl/default.key" 2048
    openssl req -new -key "/etc/nginx/ssl/default.key" -out "/etc/nginx/ssl/default.csr" -subj "/CN=default/O=default/C=UK"
    openssl x509 -req -days 365 -in "/etc/nginx/ssl/default.csr" -signkey "/etc/nginx/ssl/default.key" -out "/etc/nginx/ssl/default.crt"
    chmod 644 /etc/nginx/ssl/default.key
fi

if [ ! -f /etc/nginx/ssl/api.efranco.pp.crt ]; then
    openssl genrsa -out "/etc/nginx/ssl/api.efranco.pp.key" 2048
    openssl req -new -key "/etc/nginx/ssl/api.efranco.pp.key" -out "/etc/nginx/ssl/api.efranco.pp.csr" -config "/etc/nginx/ssl/api.efranco.pp.cnf"
    openssl x509 -req -days 365 -in "/etc/nginx/ssl/api.efranco.pp.csr" -signkey "/etc/nginx/ssl/api.efranco.pp.key" -out "/etc/nginx/ssl/api.efranco.pp.crt" -extensions req_ext -extfile "/etc/nginx/ssl/api.efranco.pp.cnf"
    chmod 644 /etc/nginx/ssl/api.efranco.pp.key
fi

if [ ! -f /etc/nginx/ssl/laravel-reverb.pp.crt ]; then
    openssl genrsa -out "/etc/nginx/ssl/laravel-reverb.pp.key" 2048
    openssl req -new -key "/etc/nginx/ssl/laravel-reverb.pp.key" -out "/etc/nginx/ssl/laravel-reverb.pp.csr" -config "/etc/nginx/ssl/laravel-reverb.pp.cnf"
    openssl x509 -req -days 365 -in "/etc/nginx/ssl/laravel-reverb.pp.csr" -signkey "/etc/nginx/ssl/laravel-reverb.pp.key" -out "/etc/nginx/ssl/laravel-reverb.pp.crt" -extensions req_ext -extfile "/etc/nginx/ssl/laravel-reverb.pp.cnf"
    chmod 644 /etc/nginx/ssl/laravel-reverb.pp.key
fi

if [ ! -f /etc/nginx/ssl/front-efranco.pp.crt ]; then
    openssl genrsa -out "/etc/nginx/ssl/front-efranco.pp.key" 2048
    openssl req -new -key "/etc/nginx/ssl/front-efranco.pp.key" -out "/etc/nginx/ssl/front-efranco.pp.csr" -config "/etc/nginx/ssl/front-efranco.pp.cnf"
    openssl x509 -req -days 365 -in "/etc/nginx/ssl/front-efranco.pp.csr" -signkey "/etc/nginx/ssl/front-efranco.pp.key" -out "/etc/nginx/ssl/front-efranco.pp.crt" -extensions req_ext -extfile "/etc/nginx/ssl/front-efranco.pp.cnf"
    chmod 644 /etc/nginx/ssl/front-efranco.pp.key
fi

# Start crond in background
crond -l 2 -b

# Start nginx in foreground
nginx
