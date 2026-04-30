@echo off
title Create Dev Admin User
echo.
echo ============================================================
echo   Creating local admin user for Medusa admin panel
echo ============================================================
echo.
echo   Email:    admin-local@dentauae.com
echo   Password: Admin@Local2026!
echo.
cd /d %~dp0medusa-dentalanti
npx medusa user --email admin-local@dentauae.com --password Admin@Local2026!
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo The local admin may already exist. Try logging in with:
    echo   admin-local@dentauae.com / Admin@Local2026!
    echo.
    pause
    exit /b 0
)
echo.
echo Done! You can now log in at http://localhost:9000/app
echo.
pause
