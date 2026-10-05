# CasaFit

Base Flutter para la aplicación Android de entrenamiento en casa. El alcance y las decisiones vigentes están en [PROJECT.md](PROJECT.md), [ARCHITECTURE_MVP.md](ARCHITECTURE_MVP.md) y [UX_UI_DESIGN.md](UX_UI_DESIGN.md).

## Requisitos

- Flutter 3.47.6 o compatible, con Dart 3.13.5.
- Android Studio y Android SDK API 37.
- Android API 26 o superior para ejecutar la aplicación.

En este equipo el SDK Flutter está en `.toolchain/flutter/` y se excluye de Git. En otro equipo, instalar Flutter según la documentación oficial y añadir `flutter/bin` al `PATH`.

## Comandos

Ejecutar desde la raíz del repositorio:

```powershell
flutter pub get
dart run tool/build_exercise_catalog.dart
dart run tool/build_routine_catalog.dart
dart run build_runner build
dart format lib test tool
flutter analyze
flutter test
flutter build apk --debug
flutter run
```

Si Flutter no está en el `PATH` de este equipo, sustituir `flutter` por `.\.toolchain\flutter\bin\flutter.bat` y `dart` por `.\.toolchain\flutter\bin\cache\dart-sdk\bin\dart.exe`.

El primer generador crea `assets/data/exercises_v1.json` a partir de `EXERCISE_CATALOG.md` y `EXERCISE_INSTRUCTIONS.md`; el segundo crea `assets/data/routines_v1.json` a partir del catálogo de ejercicios y las plantillas declaradas en `tool/build_routine_catalog.dart`. La generación de Drift crea `lib/core/database/app_database.g.dart`. El esquema actual es la versión 4; cualquier cambio posterior debe incrementar `schemaVersion` y añadir una migración probada antes de distribuirse.

## Estado de esta fase

La pantalla Inicio y los cinco destinos de la barra inferior son navegables. El perfil local permite configurar objetivo, nivel, días disponibles, duración preferida y unidad de peso, además de nombre, edad, altura y peso inicial opcionales. Se puede crear desde Inicio o Perfil y editar después. Drift guarda un único perfil, sus preferencias y días disponibles; el peso se conserva internamente en kg.

La biblioteca Ejercicios carga 60 ejercicios locales en SQLite, permite buscar por nombre y filtrar por categoría y dificultad desde una hoja inferior. El detalle presenta instrucciones, respiración, seguridad, variantes y una alternativa para ejercicios de alto impacto. Las imágenes locales todavía están pendientes y se muestra un marcador de posición.

Rutinas presenta 12 plantillas oficiales locales, filtrables por objetivo y nivel. El detalle muestra los ejercicios en orden, series, repeticiones o tiempo, descansos y seguridad; cada ejercicio abre sus instrucciones. Las plantillas son de solo lectura. El inicio de sesiones, las copias editables, las medidas y las gráficas se desarrollarán después. Progreso mantiene su estado inicial.
