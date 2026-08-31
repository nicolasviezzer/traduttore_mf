@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

rem Push automatico: aggiunge tutto, committa e pubblica su GitHub.
rem   push.bat                      -> messaggio con data e ora
rem   push.bat sistemato il prompt  -> usa questo messaggio

cd /d "%~dp0"

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
  echo [X] Questa cartella non e un repository git.
  goto :fine
)

for /f "delims=" %%b in ('git rev-parse --abbrev-ref HEAD') do set "BRANCH=%%b"
echo Branch: !BRANCH!
echo.

rem --- messaggio di commit -------------------------------------------------
set "MSG=%*"
if "!MSG!"=="" (
  for /f "delims=" %%d in ('powershell -NoProfile -Command "Get-Date -Format \"yyyy-MM-dd HH:mm\""') do set "STAMP=%%d"
  set "MSG=Aggiornamento !STAMP!"
)

rem --- c'e' qualcosa da committare? ----------------------------------------
set "MODIFICHE="
for /f "delims=" %%s in ('git status --porcelain') do set "MODIFICHE=1"

if defined MODIFICHE (
  echo File modificati:
  git status --short
  echo.
  git add -A
  git commit -m "!MSG!"
  if errorlevel 1 (
    echo [X] Commit fallito.
    goto :fine
  )
  echo [OK] Commit creato: !MSG!
) else (
  echo Nessuna modifica da committare.
)
echo.

rem --- allineo al remoto prima di pubblicare --------------------------------
echo Allineo con origin/!BRANCH! ...
git pull --rebase origin !BRANCH!
if errorlevel 1 (
  echo.
  echo [X] Il rebase non e riuscito: probabilmente ci sono conflitti.
  echo     Risolvili a mano, poi:  git rebase --continue
  echo     Per annullare tutto:    git rebase --abort
  goto :fine
)
echo.

rem --- push -----------------------------------------------------------------
git push origin !BRANCH!
if errorlevel 1 (
  echo.
  echo [X] Push fallito. Controlla connessione e permessi sul repository.
  goto :fine
)

echo.
echo [OK] Fatto. Il deploy su GitHub Pages parte da solo tra qualche secondo.
echo      Stato: https://github.com/nicolasviezzer/traduttore_mf/actions

:fine
echo.
pause
endlocal
