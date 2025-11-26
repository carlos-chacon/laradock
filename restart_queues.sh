#!/bin/bash

echo "Deteniendo workers existentes..."

# Matar procesos queue:work (solo los que NO sean este mismo script ni el grep)
PIDS=$(ps aux | grep "php artisan queue:work" | grep -v grep | awk '{print $2}')

if [ -z "$PIDS" ]; then
    echo "No hay procesos activos para detener."
else
    echo "Matando procesos: $PIDS"
    kill -9 $PIDS
fi

echo "Iniciando workers nuevamente..."

# Lanzar los workers en segundo plano
php artisan queue:work database --queue=default --timeout=0 --daemon >> storage/logs/queue-default.log 2>&1 &
php artisan queue:work database --queue=long-running-processes --timeout=0 --daemon >> storage/logs/queue-long.log 2>&1 &

echo "Workers reiniciados correctamente."
