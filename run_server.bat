@ECHO OFF
cd /d "%~dp0"

where bash >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    bash "%~dp0run_server.sh"
    exit /b %ERRORLEVEL%
)

ECHO Subiendo server efranco local.

docker-compose up -d nginx postgres workspace redis redis-webui
@REM docker-compose up -d nginx postgres workspace php-worker redis redis-webui

ECHO Esperando a que workspace este listo...
docker-compose exec -T workspace bash -c "sleep 5"

ECHO Reiniciando queues...
docker-compose exec -T workspace bash -c "cd /var/www/efranco && ./restart_queues.sh"

REM PAUSE
