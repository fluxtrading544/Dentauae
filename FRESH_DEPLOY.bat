@echo off
title DentaUAE — Fresh Deploy
color 0A
cd /d F:\dentalanti
echo.
echo =====================================================
echo   NUCLEAR CLEAN + FRESH DEPLOYMENT
echo   - Wipes all Docker images/volumes/cache on VPS
echo   - Rebuilds everything from scratch
echo   - ~10-15 min total
echo =====================================================
echo.
python FRESH_DEPLOY.py
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR — check output above
    pause
)
