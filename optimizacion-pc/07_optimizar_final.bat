@echo off
:: ============================================================================
::  OPTIMIZADOR FINAL - ultimos tweaks REALES (seguros, sin plan de energia)
::  -> Solo DOBLE CLIC. Permiso de admin solo. Reversible.
::  -> ESTE ES EL ULTIMO SET UTIL. Lo demas ya es placebo o rompe Windows.
:: ============================================================================

:: --- AUTO-ELEVACION ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

title Optimizador FINAL - ultimos tweaks reales
color 0c
echo ============================================================
echo   OPTIMIZADOR FINAL - los ultimos tweaks que valen la pena
echo ============================================================
echo.

echo [0/6] Creando punto de restauracion...
powershell -Command "Checkpoint-Computer -Description 'Antes optimizar final' -RestorePointType 'MODIFY_SETTINGS'" 2>nul

echo [1/6] USB Selective Suspend OFF (raton/teclado no se duermen)...
:: Aplica a todos los hubs USB: que NO permitan suspender el dispositivo
powershell -Command "Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Enum\USB' -Recurse | Where-Object { $_.Name -like '*Device Parameters*' } | ForEach-Object { Set-ItemProperty -Path $_.PSPath -Name 'AllowIdleIrpInD3' -Value 0 -ErrorAction SilentlyContinue }" 2>nul
:: Tambien por la politica global de USB
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v DisableSelectiveSuspend /t REG_DWORD /d 1 /f >nul 2>&1

echo [2/6] Desactivando Fast Startup (arranque limpio)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f >nul 2>&1

echo [3/6] Desactivando Widgets / Noticias e intereses...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v AllowNewsAndInterests /t REG_DWORD /d 0 /f >nul 2>&1

echo [4/6] Desactivando busqueda web en el menu Inicio...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d 1 /f >nul 2>&1

echo [5/6] Desactivando Xbox Game Bar...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul 2>&1

echo [6/6] Desactivando Storage Sense...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\StorageSense" /v AllowStorageSenseGlobal /t REG_DWORD /d 0 /f >nul 2>&1

echo.
echo ============================================================
echo   LISTO. Ultimos tweaks aplicados. REINICIA el PC.
echo.
echo   Este era el ultimo set util. Mas alla de aqui ya es
echo   placebo o riesgo. Lo que de verdad falta: NVIDIA Reflex
echo   On+Boost dentro de Valorant.
echo ============================================================
echo.
pause
