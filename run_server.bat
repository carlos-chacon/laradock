@ECHO OFF
ECHO subiendo server migrations-ef2-to-ef4 local.

docker-compose up -d nginx postgres workspace redis redis-webui
@REM docker-compose up -d nginx postgres workspace php-worker redis redis-webui

REM PAUSE
