@ECHO OFF
ECHO subiendo server efranco local.

@REM docker-compose up -d nginx postgres workspace workspace-8.2 redis redis-webui
docker-compose up -d nginx postgres workspace php-worker redis redis-webui

REM PAUSE
