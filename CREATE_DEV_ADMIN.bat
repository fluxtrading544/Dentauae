@echo off
title Create Dev Admin User
echo.
echo ============================================================
echo   Creating local admin user for Medusa admin panel
echo ============================================================
echo.
echo   Email:    admin@dentauae.com
echo   Password: Admin@Local2024
echo.
cd /d %~dp0medusa-dentalanti
npx medusa user --email admin@dentauae.com --password Admin@Local2024
echo.
echo Done! You can now log in at http://localhost:9000/app
echo.
pause
