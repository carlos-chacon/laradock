#!/bin/bash

# Ejecuta los workers en segundo plano con salida a logs
php artisan queue:work database --queue=default --timeout=0 --daemon >> storage/logs/queue-default.log 2>&1 &

php artisan queue:work database --queue=long-running-processes --timeout=0 --daemon >> storage/logs/queue-long.log 2>&1 &
