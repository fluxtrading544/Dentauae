@echo off
title VPS - Restart All Containers
cd /d F:\dentalanti
echo.
echo Restarting VPS containers...
python RESTART_NOW.py
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Installing paramiko and retrying...
    pip install paramiko
    python RESTART_NOW.py
)
