@echo off
title DentaUAE — Clean Deploy
color 0A
cd /d F:\dentalanti
echo.
echo =====================================================
echo   Full Clean Deploy to VPS
echo   Commits all fixes, cleans Docker, fresh build
echo   (~10 min total)
echo =====================================================
echo.
python CLEAN_DEPLOY.py
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR — check output above
    pause
)
