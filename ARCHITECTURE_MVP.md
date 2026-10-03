# CasaFit — Arquitectura técnica del MVP

**Estado:** diseño técnico para revisión  
**Fecha:** 2026-10-03  
**Plataforma inicial:** Android  
**Framework:** Flutter y Dart  
**Persistencia:** Drift sobre SQLite  
**Estado:** Riverpod  
**Navegación:** GoRouter  
**Gráficas:** fl_chart

Este documento complementa [PROJECT.md](PROJECT.md), [REQUIREMENTS.md](REQUIREMENTS.md) y [UX_UI_DESIGN.md](UX_UI_DESIGN.md). Define la arquitectura del MVP sin contener todavía la implementación completa.

## 1. Decisiones confirmadas

| Tema | Decisión |
|---|---|
| Unidad inicial | Kilogramos para peso y centímetros para medidas |
| Cambio de unidad | El usuario puede seleccionar kg o lb inmediatamente desde la configuración inicial y posteriormente desde Perfil |
| Edición de rutinas | El usuario puede modificar ejercicios, orden, repeticiones, tiempos y descansos sin límites artificiales de la interfaz |
| Edad | No se exigirá edad mínima para utilizar la aplicación. La edad será opcional |
| Perfil | Un único perfil local por instalación |
| Funcionamiento | Las funciones principales deben funcionar sin conexión |
| Backup | Se incorporará exportación e importación manual de datos locales |
| Contenido | El catálogo inicial se basará en contenido investigado y documentado, sin depender de un servicio remoto |
| Idioma inicial | Español |
| Publicidad | No habrá anuncios |
| Modelo de negocio MVP | Gratuito |

La libertad para modificar rutinas no elimina las validaciones de seguridad del motor de progresión automática. La edición manual puede ser flexible, pero las recomendaciones automáticas deben seguir reglas explícitas y trazables.

## 2. Arquitectura general

```text
Presentation
  Pantallas, widgets, formularios y navegación
        ↓
Application
  ViewModels Riverpod y casos de uso
        ↓
Domain
  Entidades, validaciones, métricas y reglas
        ↓
Data
  Repositorios, DAOs, mapeadores y transacciones Drift
        ↓
SQLite / Android
  Persistencia local, backup y notificaciones
```

La aplicación utilizará arquitectura feature-first con separación por capas.

Principios:

- SQLite será la fuente de verdad de los datos persistentes.
- La interfaz no accederá directamente a Drift.
- Las reglas de planes y progresión serán Dart puro.
- Las operaciones críticas se ejecutarán dentro de transacciones.
- Las fechas históricas se almacenarán en UTC.
- Las horas de recordatorios se almacenarán como horario local.
- Las rutinas oficiales serán plantillas protegidas.
- Las rutinas personalizadas serán copias editables.
- Las sesiones guardarán una instantánea de la prescripción utilizada.

## 3. Estructura recomendada

```text
lib/
  main.dart
  app.dart

  core/
    constants/
    errors/
    result/
    time/
    theme/
    routing/
    database/
      app_database.dart
      tables/
      daos/
      migrations/
      seed/
    notifications/
    backup/
    units/
    utils/

  shared/
    widgets/
    dialogs/
    formatters/
    accessibility/

  features/
    profile/
      domain/
      data/
      application/
      presentation/
    exercises/
      domain/
      data/
      application/
      presentation/
    routines/
      domain/
      data/
      application/
      presentation/
    plans/
      domain/
      data/
      application/
      presentation/
    workout/
      domain/
      data/
      application/
      presentation/
    progress/
      domain/
      data/
      application/
      presentation/
    reminders/
      domain/
      data/
      application/
      presentation/
    settings/
      domain/
      data/
      application/
      presentation/
```

## 4. Responsabilidades de las capas

| Capa | Responsabilidad |
|---|---|
| Presentation | Mostrar estado, recoger eventos, formularios, accesibilidad y navegación simple |
| Application | Coordinar casos de uso y transformar resultados en estado de UI |
| Domain | Entidades, value objects, validaciones, métricas y reglas de negocio |
| Data | Consultas Drift, DAOs, repositorios, mapeos y transacciones |
| Core | Infraestructura común, base de datos, errores, reloj, tema, backup y notificaciones |

Los repositorios tendrán interfaces en `domain` e implementaciones concretas en `data`.

## 5. Entidades principales

### Perfil y configuración

`UserProfile`:

- `id`
- `displayName`
- `age` opcional
- `heightCm` opcional
- `initialWeightKg` opcional
- `goal`
- `level`
- `onboardingCompleted`
- `createdAt`
- `updatedAt`

`UserPreferences`:

- `profileId`
- `weightUnit`: kg o lb
- `lengthUnit`: cm en el MVP
- `themeMode`
- `soundEnabled`
- `vibrationEnabled`
- `notificationsEnabled`
- `locale`

La edad no será obligatoria ni se usará para bloquear el acceso. Se mostrará un aviso general de seguridad, sin diagnóstico médico.

### Ejercicios

`Exercise`:

- identificador estable tipo `push_up_classic`
- nombre
- descripción
- instrucciones de ejecución
- respiración y control
- advertencias de seguridad
- categoría
- dificultad
- impacto articular
- intensidad
- equipamiento requerido
- imagen local
- prescripción recomendada
- descanso recomendado
- versión del catálogo

`ExerciseProgression`:

- ejercicio origen
- ejercicio destino
- dirección: más fácil o más difícil
- orden de progresión
- motivo
- notas de seguridad

### Rutinas y planes

`Routine`:

- nombre
- objetivo
- nivel
- duración estimada
- tipo: oficial, personalizada o copia
- rutina de origen
- editable
- archivada
- versión de contenido

`RoutineExercise`:

- rutina
- ejercicio
- posición
- series
- tipo de prescripción: repeticiones o segundos
- repeticiones objetivo
- segundos objetivo
- descanso
- notas

`PersonalPlan`:

- perfil
- objetivo
- nivel
- duración preferida
- versión del algoritmo
- fecha de generación
- estado

`PlanAssignment`:

- plan
- día de la semana
- rutina asignada
- orden
- activo

### Sesiones

`WorkoutSession`:

- perfil
- rutina
- plan opcional
- inicio y final en UTC
- estado: activa, pausada, completada o abandonada
- posición actual
- fase actual
- inicio y duración objetivo de la fase
- duración real
- porcentaje completado
- esfuerzo de 1 a 10
- molestia: ninguna, leve o dolor/detenerse
- notas

`WorkoutExerciseLog` y `WorkoutSetLog` registrarán la ejecución real por ejercicio y por serie.

Los valores objetivo se copiarán al comenzar una sesión para que editar una rutina después no altere el historial.

### Progreso

`BodyMeasurement`:

- perfil
- fecha de medición
- nota

`BodyMeasurementValue`:

- medición
- tipo de medida
- valor canónico
- unidad canónica

Medidas iniciales recomendadas para registrar desde casa:

- peso corporal;
- cintura;
- cadera;
- pecho;
- brazo;
- muslo.

No se calculará porcentaje de grasa corporal en el MVP, porque una estimación doméstica sin método fiable podría inducir a conclusiones incorrectas.

`PersonalRecord`:

- perfil
- ejercicio
- métrica: repeticiones o segundos
- valor
- fecha
- sesión de origen

### Progresión y recordatorios

`AppliedProgression` registrará cada decisión del motor:

- regla y versión
- sesión que la originó
- rutina o plan afectado
- decisión: aumentar, mantener o reducir
- valor anterior
- valor nuevo
- motivo explicado al usuario

`Reminder` y `ReminderDay` almacenarán recordatorios de entrenamiento, medidas, progreso y resumen semanal.

## 6. Tablas SQLite

Tablas principales:

```text
user_profiles
user_preferences
profile_available_days
profile_excluded_exercises
exercises
exercise_muscle_groups
exercise_progressions
routines
routine_exercises
personal_plans
plan_assignments
workout_sessions
workout_exercise_logs
workout_set_logs
body_measurements
body_measurement_values
personal_records
applied_progressions
reminders
reminder_days
app_metadata
```

Relaciones esenciales:

```text
user_profiles
 ├── user_preferences
 ├── personal_plans
 ├── workout_sessions
 ├── body_measurements
 ├── reminders
 └── applied_progressions

routines
 └── routine_exercises
      └── exercises

workout_sessions
 └── workout_exercise_logs
      └── workout_set_logs
```

Todas las claves foráneas deben estar activadas. Los registros derivados de un perfil deben eliminarse en cascada al ejecutar el borrado total. Los ejercicios oficiales deben conservarse.

## 7. Restricciones e índices

Restricciones:

- una sola fila de perfil local;
- días entre 1 y 7;
- esfuerzo entre 1 y 10;
- porcentaje completado entre 0 y 1;
- posiciones únicas dentro de una rutina;
- series únicas dentro de un ejercicio registrado;
- un solo plan activo por perfil;
- una sola sesión activa o pausada por perfil;
- prescripción de repeticiones o tiempo, no ambas como principal;
- valores físicos positivos;
- rutinas oficiales no editables;
- sesiones abandonadas excluidas de métricas de constancia;
- progresión bloqueada ante dolor, molestia, esfuerzo alto o bajo rendimiento.

Índices:

```text
sessions(profile_id, started_at_utc DESC)
sessions(profile_id, status)
workout_exercise_logs(exercise_id, session_id)
workout_set_logs(exercise_log_id, set_index)
body_measurements(profile_id, measured_at_utc DESC)
body_measurement_values(metric_type, measurement_id)
applied_progressions(profile_id, created_at_utc DESC)
routine_exercises(routine_id, position)
plan_assignments(plan_id, weekday, sequence)
reminders(profile_id, enabled)
```

## 8. Repositorios y casos de uso

Repositorios:

- `ProfileRepository`
- `PreferencesRepository`
- `ExerciseRepository`
- `RoutineRepository`
- `PersonalPlanRepository`
- `WorkoutRepository`
- `MeasurementRepository`
- `ProgressRepository`
- `ReminderRepository`
- `BackupRepository`

Casos de uso principales:

- crear y editar perfil;
- actualizar unidades y preferencias;
- consultar y filtrar ejercicios;
- crear, copiar y editar rutinas;
- generar y activar un plan;
- iniciar, pausar, reanudar y abandonar una sesión;
- registrar ejercicios, series, descansos y resumen;
- guardar peso y medidas;
- consultar métricas y gráficas;
- evaluar y aplicar progresión;
- crear y programar recordatorios;
- exportar e importar backup;
- borrar registros individuales;
- borrar todos los datos.

El cierre de una sesión será una operación transaccional que guardará la sesión, sus registros, marcas personales, métricas y decisión de progresión.

## 9. Riverpod

Providers de infraestructura:

- `databaseProvider`
- `clockProvider`
- `notificationServiceProvider`
- `backupServiceProvider`
- repositorios y motores de reglas

Providers de lectura:

- perfil actual;
- plan activo;
- rutinas oficiales;
- biblioteca filtrada;
- historial;
- métricas de progreso;
- recordatorios activos;
- sesión recuperable.

Notifiers principales:

- `ProfileNotifier`
- `RoutineEditorNotifier`
- `PlanCreationNotifier`
- `ActiveWorkoutNotifier`
- `MeasurementNotifier`
- `ReminderNotifier`
- `BackupNotifier`
- `PrivacyNotifier`

El temporizador se calculará con timestamps, no escribiendo en SQLite cada segundo. Riverpod actualizará la pantalla periódicamente y persistirá solo cambios relevantes.

## 10. GoRouter

Destinos principales:

```text
/onboarding
/home
/routines
/routines/:routineId
/exercises
/exercises/:exerciseId
/progress
/profile
/profile/settings
/plan/create
/plan/:planId
/workout/prepare/:routineId
/workout/session/:sessionId
/workout/summary/:sessionId
/reminders
/backup
/data/delete
```

La navegación principal utilizará cinco destinos:

- Inicio;
- Rutinas;
- Ejercicios;
- Progreso;
- Perfil.

La sesión activa estará fuera del shell principal y ocultará la barra inferior.

## 11. Reglas iniciales de progresión

Estas reglas se adoptan como valores iniciales del MVP y deben quedar versionadas en el código del motor:

### Sesión exitosa

Una sesión será considerada exitosa si cumple simultáneamente:

- al menos 90 % de la sesión completada;
- esfuerzo percibido entre 1 y 7;
- sin molestia ni dolor reportado;
- sesión marcada como completada.

### Progresión positiva

Después de tres sesiones exitosas consecutivas de la misma rutina o progresión:

1. aumentar una repetición por serie, si el ejercicio usa repeticiones;
2. aumentar cinco segundos, si usa tiempo;
3. después de otras tres sesiones exitosas, reducir el descanso en cinco segundos;
4. después de otro ciclo exitoso, cambiar a una variante más difícil;
5. aplicar solo una modificación por ciclo.

El contador de sesiones consecutivas se reinicia después de cada modificación.

### Mantenimiento y reducción

- Menos del 90 % completado: mantener.
- Esfuerzo de 8 a 10: mantener y mostrar explicación.
- Molestia leve: mantener y bloquear progresión automática.
- Dolor o necesidad de detenerse: detener la progresión, mostrar mensaje de seguridad y mantener la dificultad.
- Dos sesiones consecutivas de bajo rendimiento: reducir un nivel de volumen o usar una variante más fácil.

Las reglas nunca diagnostican lesiones ni sustituyen la opinión de un profesional de salud.

## 12. Horarios predeterminados

Los horarios iniciales serán editables desde el primer momento:

| Recordatorio | Valor inicial |
|---|---|
| Entrenamiento | 18:00 en los días seleccionados por el usuario |
| Registro de peso y medidas | Domingo a las 09:00 |
| Resumen semanal | Domingo a las 20:00 |
| Nueva progresión | Inmediatamente después de la sesión que la genera |

La aplicación solicitará el permiso de notificaciones después de crear el primer recordatorio. Si el usuario lo rechaza, el resto de la aplicación seguirá funcionando.

## 13. Backup local

El MVP tendrá exportación e importación manual para prevenir pérdida de datos.

### Exportación

Se generará un archivo local versionado, preferiblemente JSON empaquetado en ZIP, que incluya:

- perfil y preferencias;
- días disponibles y exclusiones;
- rutinas personalizadas;
- planes;
- historial de sesiones;
- peso y medidas;
- marcas personales;
- progresiones aplicadas;
- recordatorios.

No se incluirán IDs internos de notificaciones ni datos temporales del sistema operativo.

El archivo tendrá:

- versión del formato;
- fecha de exportación;
- versión de la aplicación;
- checksum o validación de integridad;
- datos serializados.

### Importación

Debe incluir:

1. selección del archivo;
2. validación de versión y contenido;
3. vista previa de datos;
4. confirmación explícita;
5. importación transaccional;
6. reprogramación de recordatorios;
7. informe de errores o registros omitidos.

La primera versión utilizará reemplazo completo del perfil local. La combinación automática de backups se deja para una evolución posterior.

## 14. Migraciones

Drift utilizará `schemaVersion` y migraciones incrementales.

Versiones independientes:

```text
schemaVersion    estructura SQLite
catalogVersion   ejercicios y rutinas oficiales
algorithmVersion reglas de recomendación y progresión
backupVersion    formato de exportación
```

Cada migración debe probarse con una base de datos de la versión anterior. Las actualizaciones del catálogo no deben modificar sesiones históricas ni rutinas personalizadas.

## 15. Validaciones y errores

Errores tipados:

- `ValidationFailure`
- `NotFoundFailure`
- `ConflictFailure`
- `DatabaseFailure`
- `MigrationFailure`
- `BackupFormatFailure`
- `NotificationPermissionFailure`
- `InsufficientDataFailure`
- `SafetyRestrictionFailure`

Todos los módulos deben soportar estados de carga, vacío, guardado, éxito y error.

Los mensajes deben explicar qué sucedió y qué puede hacer el usuario. Nunca se debe mostrar una pantalla vacía ni ocultar un error de almacenamiento.

## 16. Pruebas

### Unitarias

- validación del perfil y medidas;
- conversiones kg/lb;
- generación determinista de planes;
- reglas de progresión;
- cálculo de métricas y rachas;
- validación del backup;
- selección de ejercicios alternativos.

### Persistencia

- Drift en memoria;
- restricciones y claves foráneas;
- seed idempotente;
- borrado en cascada;
- migraciones;
- recuperación de sesiones;
- exportación e importación.

### Widgets

- onboarding;
- navegación;
- filtros;
- formularios;
- sesión activa;
- resumen;
- gráficas;
- confirmación triple de borrado;
- modo oscuro;
- texto ampliado y semántica.

### Integración Android

- funcionamiento sin internet;
- reinicio de aplicación;
- cierre forzado durante una sesión;
- permisos de notificaciones;
- recordatorios;
- backup y restauración;
- instalación en dispositivo real;
- comportamiento con batería restringida.

## 17. Plataforma Android

Como objetivo inicial se propone Android API 26 o superior, equivalente a Android 8.0+, por compatibilidad razonable con dispositivos modernos y manejo consistente de notificaciones locales.

Esta decisión debe confirmarse al crear el proyecto revisando:

- dispositivos objetivo;
- versión de Flutter utilizada;
- compatibilidad de Drift;
- compatibilidad del plugin de notificaciones;
- requisitos de publicación futura.

## 18. Riesgos

- reglas demasiado exigentes o demasiado permisivas;
- interpretaciones médicas de las recomendaciones;
- restricciones de batería que afecten recordatorios;
- pérdida del archivo de backup;
- contenido de ejercicios incompleto o inconsistente;
- aumento excesivo del alcance por backup, planes y progresión;
- cambios en rutinas que afecten el historial si no se usan snapshots.

## 19. Orden de implementación

1. Crear el proyecto Flutter Android.
2. Configurar Material 3, Riverpod, Drift, GoRouter y `fl_chart`.
3. Crear la base SQLite y la migración inicial.
4. Crear el seed del catálogo.
5. Crear navegación y estados base.
6. Implementar perfil, unidades y preferencias.
7. Implementar ejercicios y filtros.
8. Implementar rutinas oficiales.
9. Implementar copias y edición libre de rutinas.
10. Implementar sesión, temporizadores y recuperación.
11. Implementar resumen e historial.
12. Implementar peso, medidas y gráficas.
13. Implementar generación de planes.
14. Implementar progresión y explicaciones.
15. Implementar recordatorios y notificaciones.
16. Implementar exportación e importación.
17. Implementar borrado individual y borrado total.
18. Probar offline, migraciones, accesibilidad y dispositivo real.

## 20. Cambios pendientes para registrar en `PROJECT.md`

Se recomienda registrar las siguientes decisiones:

- arquitectura técnica por capas y feature-first;
- kg como unidad interna y selección inmediata de kg/lb;
- edición libre de rutinas;
- ausencia de edad mínima obligatoria;
- reglas iniciales de progresión;
- horarios predeterminados de recordatorios;
- backup local mediante exportación e importación;
- medidas corporales iniciales;
- objetivo Android API 26 como propuesta inicial;
- versionado separado de esquema, catálogo, algoritmo y backup.

También debe corregirse en `PROJECT.md` la contradicción entre la referencia inicial a libras y la decisión más reciente de iniciar con kilogramos.

