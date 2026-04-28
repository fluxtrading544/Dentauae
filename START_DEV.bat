@echo off
title DentaUAE — Local Dev
color 0A
echo.
echo ============================================================
echo   DentaUAE Local Development Environment
echo ============================================================
echo.

REM ── Step 1: Start Docker infrastructure ──────────────────────────────────────
echo [1/4] Starting Postgres + Redis via Docker...
docker compose -f docker-compose.dev.yml up -d
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Docker failed to start. Is Docker Desktop running?
    pause
    exit /b 1
)

REM ── Step 1b: Free ports 9000 and 3000 if already in use ─────────────────────
echo [1b/4] Freeing ports 9000 and 3000 if already in use...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":9000 " ^| findstr "LISTENING"') do (
    echo        Killing PID %%a on port 9000...
    taskkill /PID %%a /F >nul 2>&1
)
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":3000 " ^| findstr "LISTENING"') do (
    echo        Killing PID %%a on port 3000...
    taskkill /PID %%a /F >nul 2>&1
)

REM ── Step 2: Wait for Postgres to be ready ────────────────────────────────────
echo.
echo [2/4] Waiting for Postgres to be ready...
:wait_loop
docker compose -f docker-compose.dev.yml exec postgres pg_isready -U postgres -d medusa-dev >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    timeout /t 2 /nobreak >nul
    goto wait_loop
)
echo        Postgres is ready!

REM ── Step 3: Install dependencies if needed ───────────────────────────────────
echo.
echo [3/4] Checking dependencies...
if not exist "medusa-dentalanti\node_modules" (
    echo        Installing Medusa backend dependencies...
    cd medusa-dentalanti
    call npm install
    cd ..
)
if not exist "node_modules" (
    echo        Installing Next.js frontend dependencies...
    call npm install
)

REM ── Step 4: Open two terminal windows ────────────────────────────────────────
echo.
echo [4/4] Starting development servers...
echo.

REM Backend: medusa develop (hot-reload on port 9000, admin at /app)
echo Opening Backend terminal (Medusa develop — port 9000)...
start "DentaUAE Backend" cmd /k "cd /d %~dp0medusa-dentalanti && echo. && echo  Backend: http://localhost:9000 && echo  Admin:   http://localhost:9000/app && echo. && copy .env.development .env.local.bak >nul 2>&1 && set NODE_ENV=development && npx medusa develop"

REM Wait a moment before opening frontend
timeout /t 3 /nobreak >nul

REM Frontend: next dev (hot-reload on port 3000)
echo Opening Frontend terminal (Next.js dev — port 3000)...
start "DentaUAE Frontend" cmd /k "cd /d %~dp0 && echo. && echo  Storefront: http://localhost:3000 && echo. && npm run dev"

echo.
echo ============================================================
echo   Services starting up:
echo.
echo   Postgres:   localhost:5432  (postgres / password)
echo   Redis:      localhost:6379
echo   Backend:    http://localhost:9000
echo   Admin UI:   http://localhost:9000/app
echo   Storefront: http://localhost:3000
echo.
echo   First-time setup? Run CREATE_DEV_ADMIN.bat to create
echo   an admin user after the backend is fully started.
echo ============================================================
echo.
pause
