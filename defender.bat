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

echo Stopping Microsoft Defender services...

:: Stop Microsoft Defender Antivirus Service
sc query WinDefend | find "STATE" | find "RUNNING" > nul
if %errorLevel% == 0 (
    sc stop WinDefend
    sc config WinDefend start= disabled
)

:: Stop Microsoft Defender Advanced Threat Protection Service
sc query Sense | find "STATE" | find "RUNNING" > nul
if %errorLevel% == 0 (
    sc stop Sense
    sc config Sense start= disabled
)

:: Stop Microsoft Defender Network Inspection Service
sc query WdNisSvc | find "STATE" | find "RUNNING" > nul
if %errorLevel% == 0 (
    sc stop WdNisSvc
    sc config WdNisSvc start= disabled
)

:: Kill Microsoft Defender processes
taskkill /F /IM MsMpEng.exe /T
taskkill /F /IM NisSrv.exe /T

echo Microsoft Defender services stopped and disabled.
pause
