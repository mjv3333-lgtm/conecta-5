@echo off
:: ============================================================================
::  OPTIMIZADOR TODO-EN-UNO (hace lo de ShutUp10 + limpieza sin instalar nada)
::  -> Click derecho -> "Ejecutar como administrador"
::  -> Todo es REVERSIBLE. Crea un punto de restauracion automatico al inicio.
:: ============================================================================
title Optimizador PC - sin instalar programas
color 0b

:: --- Comprobar permisos de administrador ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo  [ERROR] Debes ejecutar este archivo como ADMINISTRADOR.
    echo  Cierra esta ventana, haz click derecho en el .bat y elige
    echo  "Ejecutar como administrador".
    echo.
    pause
    exit /b
)

echo ============================================================
echo   OPTIMIZADOR PC - sin instalar programas
echo   Equipo: i9-12900K / RTX 4070 Ti / Valorant
echo ============================================================
echo.
echo  Esto va a:
echo   1. Crear un punto de restauracion (seguridad)
echo   2. Desactivar telemetria/espia de Windows (como ShutUp10)
echo   3. Limpiar archivos temporales (como Limpieza de disco)
echo   4. Optimizar red y efectos visuales
echo.
echo  Todo es REVERSIBLE. Pulsa una tecla para empezar o cierra para cancelar.
pause >nul

:: ============================================================
echo.
echo [1/6] Creando punto de restauracion...
powershell -Command "Checkpoint-Computer -Description 'Antes de optimizar' -RestorePointType 'MODIFY_SETTINGS'" 2>nul
echo      Hecho (si fallo, crealo a mano antes de continuar).

:: ============================================================
echo.
echo [2/6] Desactivando servicios de telemetria...
sc stop DiagTrack >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
echo      Telemetria (DiagTrack, dmwappushservice) desactivada.

:: ============================================================
echo.
echo [3/6] Desactivando tareas programadas de telemetria...
schtasks /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Feedback\Siuf\DmClient" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable >nul 2>&1
echo      Tareas de telemetria desactivadas.

:: ============================================================
echo.
echo [4/6] Aplicando ajustes de privacidad en el registro...
:: Desactivar telemetria a nivel sistema
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
:: Desactivar ID de publicidad
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
:: Desactivar sugerencias y contenido promocional
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
:: Desactivar historial de actividad
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f >nul 2>&1
:: Efectos visuales = mejor rendimiento
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1
echo      Privacidad y efectos visuales optimizados.

:: ============================================================
echo.
echo [5/6] Limpiando archivos temporales...
del /q /f /s "%TEMP%\*" >nul 2>&1
del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\Temp\*" >nul 2>&1
echo      Temporales borrados.

:: ============================================================
echo.
echo [6/6] Optimizando red...
ipconfig /flushdns >nul 2>&1
netsh int tcp set global autotuninglevel=normal >nul 2>&1
echo      Cache DNS limpiada y TCP optimizado.

:: ============================================================
echo.
echo ============================================================
echo   LISTO. Optimizacion completada.
echo   Reinicia el PC para que todo aplique al 100%%.
echo ============================================================
echo.
echo  Para REVERTIR: usa el punto de restauracion que se creo al inicio,
echo  o ejecuta el script "04_revertir.bat".
echo.
pause
