@echo off
:: ============================================================================
::  USB POWER OFF - desactiva el "ahorro de energia" de TODOS los dispositivos
::  (lo del Administrador de dispositivos, pero automatico y de golpe)
::  -> Solo DOBLE CLIC. Permiso de admin solo. Reversible.
:: ============================================================================

:: --- AUTO-ELEVACION ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

title USB Power Off - sin micro-cortes de raton/teclado
color 0b
echo ============================================================
echo   Desactivando ahorro de energia de dispositivos USB...
echo   (raton, teclado y hubs no se "dormiran" nunca)
echo ============================================================
echo.

echo [1/3] Punto de restauracion...
powershell -Command "Checkpoint-Computer -Description 'Antes USB power off' -RestorePointType 'MODIFY_SETTINGS'" 2>nul

echo [2/3] Desactivando "Permitir apagar este dispositivo" en TODOS...
:: Usa la clase WMI MSPower_DeviceEnable (= la casilla del Admin. de dispositivos)
powershell -NoProfile -Command "Get-CimInstance -Namespace root\wmi -ClassName MSPower_DeviceEnable -ErrorAction SilentlyContinue | ForEach-Object { try { $_.Enable = $false; Set-CimInstance -InputObject $_ -ErrorAction SilentlyContinue } catch {} }"

echo [3/3] Desactivando USB Selective Suspend (refuerzo por registro)...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v DisableSelectiveSuspend /t REG_DWORD /d 1 /f >nul 2>&1

echo.
echo ============================================================
echo   LISTO. Tus USB ya no se apagan para ahorrar energia.
echo   REINICIA el PC para aplicar al 100%%.
echo.
echo   (Tu Viper V3 Pro y Wooting 60HE responderan siempre
echo    al instante, sin micro-cortes.)
echo ============================================================
echo.
pause
