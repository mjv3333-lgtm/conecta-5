# 🚀 Guía Completa de Optimización PC Gaming
### i9-12900K · RTX 4070 Ti · Monitor 500 Hz · Valorant

> ⚠️ **ANTES DE EMPEZAR:** crea un **Punto de Restauración** (Menú inicio → "Crear un punto de restauración" → Crear). Así puedes revertir cualquier cosa.

---

## 🎯 Prioridad: lo que MÁS importa para input lag
Hazlo en este orden. Lo de arriba pesa 10x más que lo de abajo.

1. ✅ **NVIDIA Reflex On+Boost** dentro de Valorant ← EL rey
2. ✅ **Monitor a 500 Hz** (Windows)
3. ✅ **FPS sin límite + VSync Off**
4. ✅ **Aceleración de ratón OFF**
5. 🟢 Todo lo demás de esta guía = pequeños extras

---

## 🖥️ BIOS (ya hecho ✅)
- [x] Hyper-Threading → Habilitado
- [x] Estados C de la CPU → Deshabilitado
- [x] Resizable BAR (CAM) + Above 4G → Habilitado
- [x] Power Limits → Ilimitados (4095)
- [x] RAM → DDR4-3600 Gear 1
- [x] Secure Boot + TPM → ON (Valorant los exige)

---

## 🪟 WINDOWS — Sistema

### Energía y rendimiento
- [ ] Plan de energía → **Ultimate Performance** (usa el .bat)
- [ ] Config → Sistema → Encendido → Modo de energía → **Máximo rendimiento**
- [ ] Desactivar **Suspensión** y **apagar pantalla** = Nunca (mientras juegas)

### Juegos
- [ ] Config → Juegos → **Modo Juego → Activado**
- [ ] Config → Juegos → Capturas → **Grabación en segundo plano → OFF**
- [ ] Config → Juegos → **Xbox Game Bar → Desactivado** (si no lo usas)

### Gráficos
- [ ] Config → Pantalla → Gráficos → **Programación de GPU acelerada por HW (HAGS) → ON**
- [ ] En esa misma pantalla → añade `VALORANT.exe` → **Alto rendimiento**

### Visuales (libera CPU/GPU)
- [ ] Menú inicio → "Ajustar la apariencia y rendimiento de Windows" → **Ajustar para obtener el mejor rendimiento** (o personalizado dejando "suavizar fuentes")

### Arranque
- [ ] **Ctrl+Shift+Esc** → pestaña **Inicio** → desactiva todo lo que no uses (Spotify, Epic, etc.)
- [ ] `msconfig` → Servicios → "Ocultar servicios de Microsoft" → desactiva basura de fabricante que no uses

---

## 🖱️ RATÓN (crítico para aim)
- [ ] Config → Mouse → Config. adicional → Opciones de puntero → **DESMARCAR "Mejorar la precisión del puntero"** ← MUY importante
- [ ] Velocidad del puntero → **6/11** (el punto medio = 1:1, sin escalado)
- [ ] Software del ratón (G HUB / Synapse) → **Polling rate 1000 Hz** (o 4000/8000 si lo soporta)
- [ ] DPI fijo (ej. 800) y ajusta sensibilidad en el juego, no por Windows

---

## 🟢 NVIDIA — Panel de Control (ya casi ✅)
- [x] Power management → **Prefer maximum performance**
- [x] Preferred refresh rate → **Highest available**
- [x] Texture filtering Quality → **High performance**
- [x] Vertical sync → **Off**
- [ ] Low Latency Mode → **On** (Reflex del juego lo anula igual)
- [ ] Max Frame Rate → **Off** o un cap muy alto (ej. 800)

---

## 🎮 VALORANT — Ajustes en el juego

### Vídeo → General
- [ ] Resolución → la que uses (1440p nativa o estirada 4:3)
- [ ] Modo de pantalla → **Pantalla completa**
- [ ] Límite de FPS (Always) → **OFF** (no tienes G-Sync)
- [ ] **NVIDIA Reflex Low Latency → On + Boost** 🎯
- [ ] Multithreaded Rendering → **On**

### Vídeo → Calidad gráfica (todo al mínimo)
- [ ] Material / Texture / Detail / UI Quality → **Low**
- [ ] VSync → **Off**
- [ ] Anti-Aliasing → **None** (o MSAA 2x por nitidez)
- [ ] Anisotropic Filtering → **1x**
- [ ] Vignette / Bloom / Distortion / First Person Shadows / Cast Shadows → **Off**

### Estadísticas (para medir)
- [ ] Config → Estadísticas → **Client FPS → Texto** (para ver tus FPS reales)

---

## 🌐 RED (menos lag online)
- [ ] Usa **cable Ethernet**, no WiFi (lag y estabilidad)
- [ ] Drivers de red actualizados (web del fabricante de la placa)
- [ ] El .reg ya quita el "NetworkThrottlingIndex"
- [ ] (Opcional) DNS rápido: **1.1.1.1** (Cloudflare) o **8.8.8.8** (Google)

---

## 🧹 MANTENIMIENTO (programas confiables)
- [ ] **DDU** → reinstalar driver NVIDIA limpio (en Modo Seguro)
- [ ] Driver NVIDIA → versión **Game Ready** más reciente (o **Studio** si prefieres estabilidad)
- [ ] **O&O ShutUp10++** → quitar telemetría (aplica solo las marcadas en verde)
- [ ] **ISLC** → contra micro-tirones (deja corriendo en segundo plano)
- [ ] **Limpieza de disco** de Windows → borra temporales
- [ ] Mantén **~15% del SSD libre** (rendimiento del NVMe)

---

## 🌡️ TEMPERATURAS (vigila tu OC a 5.2 GHz)
- [ ] **HWiNFO64** → monitorea temps CPU/GPU
- [ ] En juego: CPU ideal < 80°C, GPU < 75°C
- [ ] Stress test (Cinebench): CPU no debe pasar de **~95°C** (con power limits ilimitados, vigílalo)
- [ ] Cambia pasta térmica cada 1-2 años

---

## 🚫 LO QUE NO DEBES HACER
- ❌ NO uses packs de "1000 tweaks" de internet → rompen Windows / ban de Vanguard
- ❌ NO desactives Secure Boot ni TPM → Valorant no abre
- ❌ NO toques voltajes/BCLK manuales sin saber → inestabilidad
- ❌ NO instales "boosters" (Advanced SystemCare, Razer Cortex, etc.) → bloatware
- ❌ NO pongas la RAM por encima de su velocidad real (4000) → no arranca

---

## ✅ Verificación final
- [ ] CPU-Z → Memory → DRAM Frequency ~1800 MHz (3600 Gear 1)
- [ ] Panel NVIDIA → Información del sistema → **Resizable BAR: Sí**
- [ ] Valorant → FPS estables y altos (600-900) aprovechando los 500 Hz
- [ ] Aim se siente 1:1 (sin aceleración)

---

*Hecho a medida para tu equipo. Todo es seguro y reversible. La clave del input lag son los 4 primeros puntos — el resto son extras.*
