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
dart run build_runner build
dart format lib test
flutter analyze
flutter test
flutter build apk --debug
flutter run
```

Si Flutter no está en el `PATH` de este equipo, sustituir `flutter` por `.\.toolchain\flutter\bin\flutter.bat` y `dart` por `.\.toolchain\flutter\bin\cache\dart-sdk\bin\dart.exe`.

La primera ejecución genera `lib/core/database/app_database.g.dart` con Drift. Las siguientes modificaciones al esquema deben incrementar `schemaVersion` y añadir una migración probada antes de distribuirse.

## Estado de esta fase

La pantalla Inicio y los cinco destinos de la barra inferior son navegables. Rutinas, Ejercicios, Progreso y Perfil muestran estados iniciales. Drift dispone de una tabla de metadatos y un provider, pero todavía no guarda datos de usuario. El catálogo, las sesiones, las medidas y las gráficas se implementarán en fases posteriores.
