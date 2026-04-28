@echo off
title DentaUAE — Push Fix + Redeploy Frontend
color 0A
cd /d F:\dentalanti
echo.
echo =====================================================
echo   Push proxy.ts fix + Rebuild Frontend on VPS
echo   (Backend image is OK, only frontend rebuild needed)
echo   ~5-7 min total
echo =====================================================
echo.
python PUSH_AND_REDEPLOY.py
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR — check output above
    pause
)
