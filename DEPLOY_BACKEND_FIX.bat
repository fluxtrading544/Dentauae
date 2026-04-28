@echo off
title Deploy Backend Fix
cd /d F:\dentalanti
echo.
echo =====================================================
echo   Deploying admin outDir fix + session cookie fix
echo   Push to GitHub then rebuild backend (~5-8 min)
echo =====================================================
echo.
python DEPLOY_BACKEND_FIX.py
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR - check output above
    pause
)
