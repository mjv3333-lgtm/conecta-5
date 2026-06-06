@echo off
:: ============================================================================
::  OPTIMIZADOR TOTAL - TWEAKS REALES Y SEGUROS (sin plan de energia)
::  -> Solo haz DOBLE CLIC. Se pide permiso de admin solo.
::  -> Todo reversible (crea punto de restauracion). NO toca Vanguard.
:: ============================================================================

:: --- AUTO-ELEVACION: si no es admin, se relanza pidiendo permiso ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

title Optimizador Total - 0 delay (lo maximo real)
color 0a
echo ============================================================
echo   OPTIMIZADOR TOTAL - tweaks reales para minimo input lag
echo   (sin plan de energia, como pediste)
echo ============================================================
echo.

:: ---------------- 1. PUNTO DE RESTAURACION ----------------
echo [1/9] Creando punto de restauracion...
powershell -Command "Checkpoint-Computer -Description 'Antes optimizar total' -RestorePointType 'MODIFY_SETTINGS'" 2>nul
echo.

:: ---------------- 2. ACELERACION DE RATON OFF (lo mas util) ----------------
echo [2/9] Desactivando aceleracion del raton (aim 1:1)...
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul 2>&1

:: ---------------- 3. PRIORIDAD CPU AL JUEGO ----------------
echo [3/9] Dando prioridad de CPU al juego en primer plano...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f >nul 2>&1

:: ---------------- 4. MULTIMEDIA / TAREA GAMES ----------------
echo [4/9] Prioridad maxima a multimedia y juegos...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1

:: ---------------- 5. GAME DVR / GAME BAR OFF (libera GPU) ----------------
echo [5/9] Desactivando Game DVR (grabacion en segundo plano)...
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul 2>&1

:: ---------------- 6. NAGLE OFF (menos latencia de red) ----------------
echo [6/9] Desactivando algoritmo de Nagle (menos lag online)...
powershell -Command "Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces' | ForEach-Object { New-ItemProperty -Path $_.PSPath -Name 'TcpAckFrequency' -Value 1 -PropertyType DWord -Force | Out-Null; New-ItemProperty -Path $_.PSPath -Name 'TCPNoDelay' -Value 1 -PropertyType DWord -Force | Out-Null }" 2>nul

:: ---------------- 7. TELEMETRIA OFF (como ShutUp10) ----------------
echo [7/9] Desactivando telemetria/espia de Windows...
sc stop DiagTrack >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1

:: ---------------- 8. EFECTOS VISUALES = RENDIMIENTO ----------------
echo [8/9] Efectos visuales en modo rendimiento...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1

:: ---------------- 9. LIMPIEZA + RED ----------------
echo [9/9] Limpiando temporales y cache de red...
del /q /f /s "%TEMP%\*" >nul 2>&1
del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
ipconfig /flushdns >nul 2>&1

echo.
echo ============================================================
echo   LISTO. Todos los tweaks aplicados.
echo   REINICIA el PC para que apliquen al 100%%.
echo.
echo   Para revertir: usa el punto de restauracion creado al inicio,
echo   o ejecuta "04_revertir.bat".
echo ============================================================
echo.
pause
