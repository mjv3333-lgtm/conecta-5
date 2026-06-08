@echo off
:: ============================================================================
::  SETUP COMPETITIVO FINAL - Viper V3 Pro (1000Hz) + Wooting 60HE
::  -> Solo DOBLE CLIC. Permiso de admin solo. Reversible.
::  -> Aplica TODO lo que se puede por comando. El Rapid Trigger del
::     Wooting NO se puede por script: se activa en Wootility (a mano).
:: ============================================================================

:: --- AUTO-ELEVACION ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

title Setup Competitivo - Raton + Teclado
color 0a
echo ============================================================
echo   SETUP COMPETITIVO FINAL
echo   Viper V3 Pro @ 1000Hz  +  Wooting 60HE
echo ============================================================
echo.

echo [0/4] Creando punto de restauracion...
powershell -Command "Checkpoint-Computer -Description 'Setup competitivo' -RestorePointType 'MODIFY_SETTINGS'" 2>nul

echo [1/4] RATON: aceleracion OFF + 1:1 puro...
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseSensitivity /t REG_SZ /d 10 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseHoverTime /t REG_SZ /d 0 /f >nul 2>&1

echo [2/4] TECLADO: maxima respuesta...
reg add "HKCU\Control Panel\Keyboard" /v KeyboardDelay /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Keyboard" /v KeyboardSpeed /t REG_SZ /d 31 /f >nul 2>&1

echo [3/4] COLA de datos = 16 (optimo para 1000 Hz)...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v MouseDataQueueSize /t REG_DWORD /d 16 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v KeyboardDataQueueSize /t REG_DWORD /d 16 /f >nul 2>&1

echo [4/4] Hecho.
echo.
echo ============================================================
echo   LISTO. Parte de REGISTRO aplicada. REINICIA el PC.
echo ============================================================
echo.
echo   *** FALTA LO MAS IMPORTANTE (a mano, no por script) ***
echo.
echo   WOOTING 60HE - en Wootility:
echo     1. Rapid Trigger  -^> ON  (sensitivity 0.1 mm) en W A S D
echo     2. Actuation Point -^> 1.5 mm
echo     3. Polling Rate    -^> maximo (1000 Hz)
echo.
echo   VALORANT - en Video/General:
echo     1. NVIDIA Reflex Low Latency -^> On + Boost
echo     2. Raw Input Buffer -^> On
echo.
echo   Esto vale MAS que todo el registro junto.
echo ============================================================
echo.
pause
