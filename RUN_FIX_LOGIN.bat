@echo off
title Medusa Admin Login Fix
cd /d F:\dentalanti
echo.
echo =====================================================
echo   Medusa v2 Admin Login Repair
echo   Step 1: Push config fix to GitHub
echo   Step 2: Rebuild backend + fix auth_identity
echo   Takes about 10-15 minutes total
echo =====================================================
echo.

echo Pushing session_cookie fix to GitHub...
git add medusa-dentalanti\medusa-config.ts
git commit -m "fix: session_cookie.secure=false so cookies work through Nginx HTTP proxy" 2>nul
if %ERRORLEVEL% EQU 0 (
    echo Committed. Pushing...
    git push origin main
    if %ERRORLEVEL% NEQ 0 (
        echo WARNING: Push failed - will continue with current VPS code
    ) else (
        echo Pushed successfully!
    )
) else (
    echo Nothing new to commit - config may already be pushed.
)

echo.
echo Running login repair script...
python fix_login_final.py
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Script failed. Ensure Python is installed.
    pause
)
