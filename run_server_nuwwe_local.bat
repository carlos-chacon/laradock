@ECHO OFF
ECHO subiendo server 8.0

@REM cd C:\Users\PERSONAL\Documents\proyectos\proyectos\laradock 
docker-compose up -d nginx workspace php-worker redis redis-webui
@REM cd C:\Users\PERSONAL\Documents\proyectos\proyectos\nuwwe
REM PAUSE
