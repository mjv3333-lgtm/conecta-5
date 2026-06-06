@echo off
:: ============================================================================
::  OPTIMIZADOR EXTRA - 10 tweaks DIFERENTES (seguros, sin plan de energia)
::  -> Solo DOBLE CLIC. Se pide permiso de admin solo.
::  -> Reversible (crea punto de restauracion). NO toca Vanguard.
:: ============================================================================

:: --- AUTO-ELEVACION ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

title Optimizador EXTRA - 10 tweaks diferentes
color 0d
echo ============================================================
echo   OPTIMIZADOR EXTRA - 10 tweaks distintos a los anteriores
echo ============================================================
echo.

echo [0/10] Creando punto de restauracion...
powershell -Command "Checkpoint-Computer -Description 'Antes optimizar extra' -RestorePointType 'MODIFY_SETTINGS'" 2>nul

echo [1/10] Desactivando Power Throttling (nucleos a tope)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 1 /f >nul 2>&1

echo [2/10] Menus instantaneos (MenuShowDelay=0)...
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul 2>&1

echo [3/10] Apps en segundo plano OFF...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul 2>&1

echo [4/10] Quitando retraso de arranque de programas...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >nul 2>&1

echo [5/10] Desactivando telemetria de NVIDIA...
schtasks /Change /TN "NvTmRep_CrashReport1_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" /Disable >nul 2>&1
schtasks /Change /TN "NvTmRep_CrashReport2_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" /Disable >nul 2>&1
schtasks /Change /TN "NvTmRep_CrashReport3_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" /Disable >nul 2>&1
schtasks /Change /TN "NvTmRep_CrashReport4_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" /Disable >nul 2>&1

echo [6/10] Desactivando transparencia (libera GPU)...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul 2>&1

echo [7/10] Apagado mas rapido...
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout /t REG_SZ /d 2000 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v HungAppTimeout /t REG_SZ /d 2000 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v AutoEndTasks /t REG_SZ /d 1 /f >nul 2>&1

echo [8/10] Delivery Optimization OFF (no compartir tu internet)...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f >nul 2>&1

echo [9/10] Quitando reserva de ancho de banda QoS...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f >nul 2>&1

echo [10/10] Notificaciones OFF mientras juegas (pantalla completa)...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\QuietHours" /v Enable /t REG_DWORD /d 1 /f >nul 2>&1

echo.
echo ============================================================
echo   LISTO. 10 tweaks extra aplicados. REINICIA el PC.
echo   Revertir: punto de restauracion creado al inicio.
echo ============================================================
echo.
pause
