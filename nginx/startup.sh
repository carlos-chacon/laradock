#!/bin/bash

if [ ! -f /etc/nginx/ssl/default.crt ]; then
    openssl genrsa -out "/etc/nginx/ssl/default.key" 2048
    openssl req -new -key "/etc/nginx/ssl/default.key" -out "/etc/nginx/ssl/default.csr" -subj "/CN=default/O=default/C=UK"
    openssl x509 -req -days 365 -in "/etc/nginx/ssl/default.csr" -signkey "/etc/nginx/ssl/default.key" -out "/etc/nginx/ssl/default.crt"
    chmod 644 /etc/nginx/ssl/default.key
fi

if [ ! -f /etc/nginx/ssl/nuwwe.pp.crt ]; then
    openssl genrsa -out "/etc/nginx/ssl/nuwwe.pp.key" 2048
    openssl req -new -key "/etc/nginx/ssl/nuwwe.pp.key" -out "/etc/nginx/ssl/nuwwe.pp.csr" -subj "/CN=nuwwe.pp/O=nuwwe.pp/C=UK"
    openssl x509 -req -days 365 -in "/etc/nginx/ssl/nuwwe.pp.csr" -signkey "/etc/nginx/ssl/nuwwe.pp.key" -out "/etc/nginx/ssl/nuwwe.pp.crt"
    chmod 644 /etc/nginx/ssl/nuwwe.pp.key
fi

if [ ! -f /etc/nginx/ssl/apipdf-nuwwe.pp.crt ]; then
    openssl genrsa -out "/etc/nginx/ssl/apipdf-nuwwe.pp.key" 2048
    openssl req -new -key "/etc/nginx/ssl/apipdf-nuwwe.pp.key" -out "/etc/nginx/ssl/apipdf-nuwwe.pp.csr" -subj "/CN=apipdf-nuwwe.pp/O=apipdf-nuwwe.pp/C=UK"
    if [ -f /etc/nginx/config_ssl/nuwwe_v3.ext ]; then
        openssl x509 -req -days 365 -in "/etc/nginx/ssl/apipdf-nuwwe.pp.csr" -signkey "/etc/nginx/ssl/apipdf-nuwwe.pp.key" -out "/etc/nginx/ssl/apipdf-nuwwe.pp.crt" -extfile "/etc/nginx/config_ssl/nuwwe_v3.ext"
    else
        openssl x509 -req -days 365 -in "/etc/nginx/ssl/apipdf-nuwwe.pp.csr" -signkey "/etc/nginx/ssl/apipdf-nuwwe.pp.key" -out "/etc/nginx/ssl/apipdf-nuwwe.pp.crt" -extfile <(printf "authorityKeyIdentifier=keyid,issuer\nbasicConstraints=CA:FALSE\nkeyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment\nsubjectAltName = @alt_names\n\n[alt_names]\nDNS.1 = apipdf-nuwwe.pp\nDNS.2 = *.apipdf-nuwwe.pp\n")
    fi
    chmod 644 /etc/nginx/ssl/apipdf-nuwwe.pp.key
fi

# Start crond in background
crond -l 2 -b

# Start nginx in foreground
nginx
