@echo off
title DentaUAE VPS Deployment
color 0A
echo.
echo ============================================
echo    DentaUAE - VPS Deployment Launcher
echo ============================================
echo.

:: Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python is not installed or not in PATH.
    echo Please install Python from https://python.org and try again.
    pause
    exit /b 1
)

echo Python found. Starting deployment script...
echo.

:: Run the deployment script
python "%~dp0deploy_vps.py"

echo.
if %errorlevel% neq 0 (
    color 0C
    echo DEPLOYMENT FAILED - See error above.
) else (
    color 0A
    echo DEPLOYMENT FINISHED.
)
pause
