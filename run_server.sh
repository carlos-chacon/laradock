#!/bin/bash

cd "$(dirname "$0")"

echo "Subiendo server efranco local."

docker-compose up -d nginx postgres workspace redis redis-webui

echo "Esperando a que workspace este listo..."
docker-compose exec -T workspace bash -c "sleep 5"

echo "Reiniciando queues..."
docker-compose exec -T workspace bash -c "cd /var/www/efranco && ./restart_queues.sh"
