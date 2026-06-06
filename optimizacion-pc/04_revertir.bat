@echo off
:: ============================================================================
::  REVERTIR optimizaciones (vuelve a dejar Windows como estaba)
::  -> Click derecho -> "Ejecutar como administrador"
:: ============================================================================
title Revertir optimizaciones
color 0e

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo  [ERROR] Ejecutalo como ADMINISTRADOR.
    pause
    exit /b
)

echo Revirtiendo cambios...

:: --- Reactivar servicios de telemetria ---
sc config DiagTrack start= auto >nul 2>&1
sc start DiagTrack >nul 2>&1
sc config dmwappushservice start= auto >nul 2>&1

:: --- Reactivar tareas programadas ---
schtasks /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Enable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Enable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Enable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Enable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Feedback\Siuf\DmClient" /Enable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Enable >nul 2>&1

:: --- Quitar las claves de registro (vuelven a su valor por defecto) ---
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 0 /f >nul 2>&1

echo.
echo Listo. Todo revertido. Reinicia el PC.
pause
