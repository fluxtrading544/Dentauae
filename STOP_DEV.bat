@echo off
title DentaUAE — Stop Dev
echo.
echo Stopping Docker dev services (Postgres + Redis)...
docker compose -f docker-compose.dev.yml down
echo.
echo Done. Backend and Frontend terminal windows can be closed manually.
echo.
pause
