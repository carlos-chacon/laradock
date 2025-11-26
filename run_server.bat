@ECHO OFF
ECHO subiendo server efranco local.

docker-compose up -d nginx postgres workspace redis redis-webui
@REM docker-compose up -d nginx postgres workspace php-worker redis redis-webui

REM PAUSE
