@echo off
title Push AI Research Summarizer to GitHub
cd /d "%~dp0"

echo =====================================================================
echo       AI RESEARCH SUMMARIZER - ONE-CLICK GITHUB PUSH
echo =====================================================================
echo.

:: Check if git is installed
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Git is not installed or not in PATH.
    echo Please install Git from https://git-scm.com/
    pause
    exit /b 1
)

echo [*] Staging project files (excluding venv, node_modules, cache)...
git add .

echo.
set /p commit_msg="Enter commit message (Press Enter for 'Initial commit with Auth & Database'): "
if "%commit_msg%"=="" set commit_msg=Initial commit with Auth and Database

git commit -m "%commit_msg%"

echo.
echo [*] Checking git remote...
git remote -v

echo.
echo =====================================================================
echo  If you haven't linked your GitHub repository yet:
echo  1. Create a new repository on https://github.com/new
echo  2. Copy the repo URL (e.g. https://github.com/YOUR_USERNAME/repo.git)
echo =====================================================================
echo.
set /p repo_url="Enter your GitHub Repository URL (or press Enter if already linked): "

if not "%repo_url%"=="" (
    git remote remove origin 2>nul
    git remote add origin %repo_url%
    git branch -M main
)

echo.
echo [*] Pushing to GitHub main branch...
git push -u origin main

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [!] Push failed or remote branch not ready.
    echo If this is an existing repo with a README, try: git push -u origin main --force
) else (
    echo.
    echo [SUCCESS] Your project has been uploaded to GitHub!
)

pause
