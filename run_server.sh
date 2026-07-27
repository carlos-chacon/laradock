#!/bin/bash
echo "subiendo server migrations-ef2-to-ef4 local."

docker-compose up -d nginx postgres workspace redis redis-webui
# docker-compose up -d nginx postgres workspace php-worker redis redis-webui
