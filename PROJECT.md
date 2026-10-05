# Proyecto: CasaFit

**Nombre de trabajo de la aplicación:** AceroFit (pendiente de validación de disponibilidad y marca)

Aplicación móvil para entrenar en casa sin equipamiento y registrar el progreso personal.

## 1. Estado del proyecto

**Fase actual:** implementación de la base técnica

**Estado:** base Android, perfil, biblioteca de ejercicios y consulta de rutinas oficiales implementados; resto del MVP pendiente
**Plataforma inicial:** Android  
**Modo de funcionamiento:** local, sin necesidad de internet  
**Equipamiento:** ninguno; únicamente ejercicios con el peso corporal  

Este documento es la fuente principal de decisiones del proyecto. Cada cambio importante debe actualizar este archivo o enlazar a un documento relacionado.

La definición detallada del MVP se mantiene en [REQUIREMENTS.md](REQUIREMENTS.md). Este documento conserva las decisiones centrales y el alcance aprobado; el documento de requisitos contiene historias de usuario, prioridades y criterios de aceptación.

## 2. Visión del producto

CasaFit permitirá crear o seguir rutinas de ejercicio en casa, registrar cada sesión y visualizar la evolución del peso, medidas corporales y rendimiento.

La primera versión será privada y local. No dependerá de cuentas, servidores ni conexión a internet.

## 3. Objetivos

- Facilitar entrenamientos en casa sin equipamiento.
- Registrar sesiones, repeticiones, tiempo y esfuerzo.
- Llevar control histórico de peso y medidas.
- Mostrar progreso mediante gráficas claras.
- Proponer rutinas organizadas por objetivo y dificultad.
- Mantener los datos bajo control del usuario.
- Construir una base técnica preparada para futuras copias de seguridad o sincronización.

## 4. Alcance inicial confirmado

### Incluido en el MVP

- Aplicación Android instalable directamente en el celular.
- Perfil básico del usuario.
- Objetivos personales.
- Planes personalizados generados por un sistema experto basado en reglas, sin IA.
- Biblioteca de ejercicios sin equipamiento.
- Ejercicios clasificados por grupo muscular, tipo y dificultad.
- Rutinas preprogramadas para casa.
- Progresión adaptativa de rutinas según rendimiento e historial.
- Inicio y finalización de una sesión.
- Registro de repeticiones, tiempo, descansos, esfuerzo y notas.
- Temporizadores para ejercicios y descansos.
- Registro de peso corporal.
- Registro de medidas corporales básicas.
- Historial de entrenamientos.
- Gráfica de evolución del peso.
- Gráficas básicas de constancia y rendimiento.
- Notificaciones locales y recordatorios programados.
- Unidades seleccionables; configuración inicial en kilogramos y centímetros, con cambio inmediato a libras.
- Exportación e importación manual de datos locales para backup.
- Imágenes locales para los ejercicios.
- Borrado individual y borrado total con triple confirmación.
- Persistencia local y funcionamiento sin internet.

### Fuera del MVP

- Inicio de sesión.
- Servidor o base de datos remota.
- Red social.
- Chat con entrenador.
- Pagos o suscripciones.
- Integración con relojes y plataformas de salud.
- Rutinas que requieran pesas, bandas o máquinas.
- Inteligencia artificial generativa.
- Sistema remoto de recomendaciones.
- Red social, comunidad o chat con entrenadores.

## 5. Funcionalidades previstas

### Perfil y objetivos

- Edad opcional, sin edad mínima obligatoria, además de altura y datos básicos.
- Peso inicial y peso actual.
- Objetivo: perder peso, mejorar condición, ganar fuerza o crear hábito.
- Nivel: principiante, intermedio o avanzado.
- Días disponibles por semana.
- Preferencias de unidades.

### Ejercicios

Cada ejercicio tendrá nombre, imagen local, instrucciones, grupo muscular, tipo, dificultad, duración o repeticiones recomendadas, descanso y variantes más fáciles o difíciles.

Categorías iniciales:

- Fuerza con peso corporal.
- Cardio.
- Movilidad.
- Flexibilidad.
- Calentamiento y enfriamiento.

### Rutinas

Cada rutina tendrá objetivo, dificultad, duración aproximada, ejercicios, orden, descansos y recomendaciones de seguridad. Existirán rutinas preprogramadas y planes personalizados generados por reglas deterministas. El usuario podrá editar libremente sus rutinas y personalizar rutinas oficiales mediante copias editables.

El sistema experto considerará objetivo, nivel, disponibilidad, duración, historial y rendimiento. La progresión podrá modificar repeticiones, tiempo, descansos o variante del ejercicio, respetando límites de seguridad y reglas explicables.

### Progreso

- Peso por fecha.
- Medidas por fecha.
- Sesiones completadas.
- Tiempo total entrenado.
- Repeticiones acumuladas.
- Mejores marcas personales.
- Rachas y constancia.
- Evolución por ejercicio.
- Progresiones aplicadas y motivo de cada cambio.
- Recordatorios de entrenamiento, peso y medidas.

## 6. Decisiones técnicas iniciales

| Área | Decisión | Motivo |
|---|---|---|
| Framework | Flutter | Permite comenzar en Android y conservar una ruta futura hacia iOS |
| IDE | Android Studio | Emulador, depuración, SDK Android y distribución del APK |
| Lenguaje | Dart | Lenguaje oficial de Flutter |
| Persistencia | SQLite mediante Drift | Datos estructurados, consultas históricas y generación de estadísticas |
| Estado | Riverpod | Estado explícito, testeable y escalable |
| Navegación | GoRouter | Navegación organizada y preparada para crecer |
| Gráficas | fl_chart | Gráficas de peso, volumen y constancia |
| Diseño | Material 3 | Componentes consistentes y accesibles |
| Arquitectura | Capas + feature-first | Separación entre interfaz, lógica y almacenamiento |

Estas decisiones son iniciales y pueden cambiar mediante una decisión registrada.

## 7. Arquitectura propuesta

```text
lib/
  core/
    theme/
    routing/
    database/
    utilities/
  features/
    profile/
    exercises/
    routines/
    workouts/
    measurements/
    progress/
    notifications/
    recommendation_engine/
```

Cada funcionalidad debe separar, cuando tenga sentido:

- `presentation`: pantallas y widgets.
- `application`: casos de uso y estado.
- `domain`: entidades y reglas de negocio.
- `data`: repositorios y acceso a SQLite.

El diseño técnico detallado, incluyendo tablas, relaciones, migraciones, backup, pruebas y decisiones de plataforma, se mantiene en [ARCHITECTURE_MVP.md](ARCHITECTURE_MVP.md).

## 8. Entidades principales

- `UserProfile`
- `UserPreferences`
- `Goal`
- `Exercise`
- `ExerciseProgression`
- `Routine`
- `RoutineExercise`
- `PersonalPlan`
- `PlanAssignment`
- `WorkoutSession`
- `WorkoutExerciseLog`
- `WorkoutSetLog`
- `BodyMeasurement`
- `BodyMeasurementValue`
- `PersonalRecord`
- `ProgressionRule`
- `AppliedProgression`
- `Reminder`
- `ReminderDay`

## 9. Ciclo de vida del software

1. Descubrimiento: visión, usuarios, objetivos y restricciones.
2. Requisitos: historias de usuario y criterios de aceptación.
3. Diseño: flujos, pantallas, modelo de datos y arquitectura.
4. Implementación: desarrollo por funcionalidades pequeñas.
5. Verificación: pruebas unitarias, de interfaz y manuales.
6. Validación: uso real en el celular y revisión de experiencia.
7. Release: compilación, instalación y registro de versión.
8. Mantenimiento: correcciones, mejoras y nuevas funcionalidades.

## 10. Distribución de responsabilidades entre conversaciones

Usaremos este chat como la coordinación principal y la fuente de decisiones. Las demás conversaciones pueden trabajar como áreas especializadas:

### Chat 1 — Producto y requisitos

Define objetivos, alcance, historias de usuario, prioridades y criterios de aceptación. Todo lo aprobado se registra aquí.

### Chat 2 — UX/UI

Diseña navegación, pantallas, estados vacíos, mensajes, accesibilidad y estilo visual. No debe cambiar requisitos sin registrarlo en este documento.

### Chat 3 — Arquitectura y datos

Define estructura Flutter, entidades, tablas, repositorios, migraciones, estado y decisiones técnicas.

### Chat 4 — Implementación

Construye funcionalidades concretas siguiendo los documentos y decisiones aprobadas. Cada entrega debe indicar archivos modificados y pruebas ejecutadas.

### Chat 5 — QA y pruebas

Revisa casos límite, regresiones, instalación en Android, rendimiento, accesibilidad y funcionamiento sin internet.

### Chat 6 — Release y mantenimiento

Prepara APKs, versiones, notas de cambios, instalación en el celular y control de incidencias.

## 11. Reglas de trabajo

- No implementar funcionalidades que no tengan alcance claro.
- Cada funcionalidad debe tener criterios de aceptación.
- Mantener los datos locales como requisito principal del MVP.
- Probar siempre en emulador y en el celular real cuando sea posible.
- No almacenar datos médicos innecesarios.
- No presentar recomendaciones como diagnóstico médico.
- Registrar decisiones técnicas importantes y sus motivos.
- Trabajar en incrementos pequeños y verificables.

## 12. Próximos pasos

- [ ] Confirmar nombre provisional de la aplicación.
- [x] Definir el perfil exacto del usuario inicial.
- [x] Redactar historias de usuario del MVP.
- [x] Confirmar rutinas preprogramadas y personalizadas en el MVP.
- [x] Confirmar sistema experto basado en reglas, sin IA.
- [x] Confirmar progresión adaptativa, temporizadores y notificaciones locales.
- [x] Confirmar unidades seleccionables y borrado total con triple confirmación.
- [x] Definir estrategia inicial de progresión, esfuerzo y frecuencia.
- [x] Definir parámetros iniciales del plan personalizado.
- [x] Definir notificaciones iniciales y opción de posponer.
- [x] Definir valores iniciales de las reglas de progresión.
- [x] Definir tamaño y alcance del catálogo inicial de ejercicios.
- [x] Definir comportamiento de permisos y notificaciones en Android.
- [x] Definir horarios predeterminados de recordatorios.
- [x] Definir medidas corporales iniciales para registros domésticos fiables.
- [x] Definir backup local mediante exportación e importación.
- [x] Definir arquitectura técnica del MVP en `ARCHITECTURE_MVP.md`.
- [x] Definir las pantallas principales y navegación.
- [x] Definir la dirección UX/UI inicial en `UX_UI_DESIGN.md`.
- [ ] Validar y aprobar el nombre definitivo de la aplicación.
- [x] Crear inventario inicial de aproximadamente 60 ejercicios, variantes e imágenes.
- [x] Redactar instrucciones textuales iniciales de los ejercicios.
- [x] Definir que el contenido inicial se basará en fuentes online documentadas, sin revisión profesional obligatoria.
- [ ] Incorporar imágenes locales de ejercicios en una fase posterior.
- [ ] Validar la compatibilidad final del objetivo Android y del plugin de notificaciones.
- [x] Crear el proyecto Flutter.
- [x] Diseñar el modelo técnico inicial de SQLite.
- [x] Implementar la primera pantalla funcional.
- [x] Implementar configuración inicial y edición del perfil local.
- [x] Integrar catálogo local de 60 ejercicios, filtros y detalle con instrucciones.
- [x] Integrar 12 rutinas oficiales con ejercicios ordenados, prescripciones y descansos.
- [ ] Probar la instalación en Android.

La compilación de depuración para Android se verificó el 2026-10-05. La instalación en el AVD `Medium_Phone_API_37.0` sigue pendiente porque el equipo no tiene habilitado el controlador de aceleración del emulador Android.

## 13. Registro de decisiones

### DEC-001 — Flutter como framework inicial

**Estado:** aceptada  
**Fecha:** 2026-10-02  
**Decisión:** usar Flutter con Android Studio.  
**Motivo:** permite construir una aplicación Android moderna, mantener una posible ruta futura hacia iOS y desarrollar rápidamente interfaces, formularios y gráficas.

### DEC-002 — Aplicación local y sin equipamiento

**Estado:** aceptada  
**Fecha:** 2026-10-02  
**Decisión:** el MVP funcionará sin conexión y las rutinas iniciales usarán únicamente el peso corporal.  
**Motivo:** coincide con el uso personal previsto, reduce complejidad y permite validar el producto antes de agregar nube o dispositivos externos.

### DEC-003 — Requisitos del MVP en documento separado

**Estado:** aceptada  
**Fecha:** 2026-10-02  
**Decisión:** mantener la definición detallada del MVP en `REQUIREMENTS.md` y conservar `PROJECT.md` como fuente de decisiones centrales y enlace de referencia.  
**Motivo:** permite modularizar requisitos, historias, prioridades y criterios de aceptación sin perder una única referencia de producto.

### DEC-004 — Planes personalizados mediante sistema experto

**Estado:** aceptada  
**Fecha:** 2026-10-02  
**Decisión:** incluir en el MVP planes personalizados generados por reglas deterministas y explicables; no utilizar IA generativa ni servicios remotos.  
**Motivo:** personalizar la experiencia manteniendo funcionamiento offline, control técnico y resultados reproducibles.

### DEC-005 — Progresión adaptativa

**Estado:** aceptada  
**Fecha:** 2026-10-02  
**Decisión:** adaptar la dificultad de las rutinas conforme el usuario avance, mediante reglas de progresión y límites de seguridad.  
**Motivo:** el producto debe demostrar avances y resultados, no limitarse a registrar sesiones.

### DEC-006 — Temporizadores, recordatorios y notificaciones locales

**Estado:** aceptada  
**Fecha:** 2026-10-02  
**Decisión:** incluir temporizadores de ejercicio y descanso, además de notificaciones locales y recordatorios programados.  
**Motivo:** son capacidades esenciales para una experiencia completa de entrenamiento y constancia.

### DEC-007 — Unidades e imágenes

**Estado:** aceptada  
**Fecha:** 2026-10-02  
**Decisión:** permitir seleccionar unidades; la configuración inicial es kilogramos para peso y centímetros para medidas, con cambio inmediato a libras. Los ejercicios tendrán imágenes locales.
**Motivo:** facilita la comprensión visual y permite adaptar la experiencia sin depender de internet.

### DEC-008 — Eliminación segura de datos

**Estado:** aceptada  
**Fecha:** 2026-10-02  
**Decisión:** permitir borrar todos los datos, pero exigir triple confirmación, incluida una acción consciente final.  
**Motivo:** protege contra eliminaciones accidentales sin impedir el control total del usuario sobre sus datos locales.

### DEC-009 — Progresión por sesiones consecutivas

**Estado:** aceptada  
**Fecha:** 2026-10-02  
**Decisión:** aumentar primero repeticiones o tiempo y después cambiar a una variante más difícil. La progresión se aplicará después de tres sesiones consecutivas completadas correctamente.  
**Motivo:** permite una mejora gradual y reduce el riesgo de aumentar la dificultad demasiado pronto.

### DEC-010 — Escala de esfuerzo

**Estado:** aceptada  
**Fecha:** 2026-10-02  
**Decisión:** registrar el esfuerzo percibido en una escala de 1 a 10.  
**Motivo:** ofrece suficiente precisión para que el sistema experto decida si debe progresar, mantener o reducir la dificultad.

### DEC-011 — Frecuencia inicial del plan

**Estado:** aceptada  
**Fecha:** 2026-10-02  
**Decisión:** recomendar inicialmente 3 días semanales a principiantes, 4 a intermedios y 5 a avanzados.  
**Motivo:** adapta la carga inicial al nivel sin impedir que el usuario ajuste su disponibilidad.

### DEC-012 — Notificaciones iniciales

**Estado:** aceptada  
**Fecha:** 2026-10-02  
**Decisión:** activar inicialmente recordatorios de entrenamiento, avisos de nueva progresión y resumen semanal. El usuario podrá editar horarios, desactivar notificaciones y posponer avisos.  
**Motivo:** apoyar la constancia y mantener informado al usuario sobre sus avances.

### DEC-013 — Parámetros del plan personalizado

**Estado:** aceptada  
**Fecha:** 2026-10-02  
**Decisión:** recomendar sesiones de 15 a 45 minutos, hasta 5 días semanales, incluyendo calentamiento y enfriamiento básicos, con posibilidad de excluir ejercicios.  
**Motivo:** establecer límites seguros y útiles para la primera versión del sistema experto.

### DEC-014 — Progresión gradual con límites

**Estado:** aceptada  
**Fecha:** 2026-10-02  
**Decisión:** después de tres sesiones consecutivas exitosas, aumentar primero 1–2 repeticiones o 5 segundos; después de varias mejoras, reducir descansos y finalmente cambiar de variante. Solo se aplicará una modificación por ciclo.  
**Motivo:** permitir una adaptación progresiva y controlada.

### DEC-015 — Catálogo amplio de ejercicios

**Estado:** aceptada  
**Fecha:** 2026-10-02  
**Decisión:** el MVP tendrá aproximadamente 60 ejercicios, incluyendo fuerza, cardio, movilidad, flexibilidad, calentamiento, enfriamiento y core. Se incluirán ejercicios de impacto para usuarios que los toleren, con advertencias y alternativas cuando sea posible.  
**Motivo:** ofrecer variedad suficiente para planes personalizados sin depender de contenido remoto.

### DEC-016 — Solicitud de permisos de notificaciones

**Estado:** aceptada  
**Fecha:** 2026-10-02  
**Decisión:** solicitar permisos después de configurar el primer recordatorio, explicar su utilidad, permitir reintentar desde ajustes y ofrecer posponer avisos 10, 30 o 60 minutos.  
**Motivo:** solicitar permisos en un momento relevante y mantener la aplicación funcional si el usuario los rechaza.

### DEC-017 — Catálogo inicial de ejercicios

**Estado:** aceptada  
**Fecha:** 2026-10-02  
**Decisión:** utilizar un catálogo inicial de 60 ejercicios sin equipamiento, con variantes, prescripción inicial, nivel de impacto articular, intensidad e imagen local definidos en `EXERCISE_CATALOG.md`.  
**Motivo:** proporcionar suficiente variedad para rutinas preprogramadas y planes personalizados sin depender de internet.

### DEC-018 — Instrucciones antes que imágenes

**Estado:** aceptada  
**Fecha:** 2026-10-03  
**Decisión:** revisar primero las instrucciones textuales, ejecución, respiración, seguridad y variantes. Las imágenes quedan pospuestas para una fase posterior.  
**Motivo:** validar la calidad y seguridad del contenido antes de producir los recursos visuales.

### DEC-019 — Arquitectura UX/UI del MVP

**Estado:** propuesta aceptada para diseño detallado  
**Fecha:** 2026-10-03  
**Decisión:** utilizar cinco destinos principales: Inicio, Rutinas, Ejercicios, Progreso y Perfil. La sesión activa usará una interfaz de pantalla completa, sin barra inferior, con controles grandes, temporizadores visibles y sonido y vibración configurables.  
**Motivo:** reducir la carga cognitiva durante el ejercicio y mantener una navegación clara fuera de la sesión.

### DEC-020 — Personalización de rutinas

**Estado:** propuesta aceptada para validación  
**Fecha:** 2026-10-03  
**Decisión:** las rutinas preprogramadas funcionarán como plantillas protegidas. El usuario podrá crear rutinas propias y personalizar una rutina preprogramada mediante una copia editable, manteniendo el original sin cambios.  
**Motivo:** permitir flexibilidad sin alterar la referencia de las rutinas oficiales ni romper la trazabilidad de progresiones.

### DEC-021 — Datos iniciales y unidades

**Estado:** aceptada  
**Fecha:** 2026-10-03  
**Decisión:** serán obligatorios para crear el plan el objetivo, nivel, días concretos disponibles, duración preferida y unidad de peso. La unidad inicial será kilogramo, con cambio inmediato a libras. Edad, altura, peso y medidas serán opcionales pero recomendados.  
**Motivo:** permitir comenzar rápidamente sin bloquear al usuario, sin renunciar a una personalización más completa.

### DEC-022 — Registro de seguridad durante el entrenamiento

**Estado:** propuesta aceptada para validación técnica y de contenido  
**Fecha:** 2026-10-03  
**Decisión:** incluir una comprobación breve de molestias en el resumen y una salida visible durante la sesión. Las opciones iniciales serán “sin molestia”, “molestia leve” y “dolor o necesito detenerme”. Una molestia o dolor no será un diagnóstico y podrá impedir una progresión automática.  
**Motivo:** priorizar seguridad sin convertir la aplicación en una herramienta médica.

### DEC-023 — Criterios visibles de bajo rendimiento

**Estado:** aceptada  
**Fecha:** 2026-10-03  
**Decisión:** la interfaz explicará que una progresión puede mantenerse o reducirse cuando el usuario complete menos del 90% de la sesión, registre esfuerzo de 8 a 10, reporte dolor o acumule dos sesiones consecutivas con bajo rendimiento.  
**Motivo:** hacer comprensible y predecible el sistema experto sin pedir al usuario que configure reglas complejas.

### DEC-024 — Dirección visual y nombre de trabajo

**Estado:** propuesta aceptada para exploración de marca  
**Fecha:** 2026-10-03  
**Decisión:** explorar una identidad inspirada en energía, acero y progreso, usando como nombre de trabajo `AceroFit`. La referencia visual será un verde azulado metálico, sobrio y deportivo; no se copiarán elementos protegidos de Max Steel. La aplicación se mantendrá gratuita y sin anuncios.  
**Motivo:** diferenciar CasaFit de aplicaciones genéricas de ejercicio y comunicar fuerza sin perder claridad ni profesionalismo.

### DEC-025 — Arquitectura técnica del MVP

**Estado:** aceptada  
**Fecha:** 2026-10-03  
**Decisión:** utilizar arquitectura feature-first con capas de presentación, aplicación, dominio y datos. Riverpod gestionará el estado, Drift será la fuente de verdad local, GoRouter gestionará la navegación y las reglas del sistema experto permanecerán independientes de la interfaz. El detalle se mantiene en `ARCHITECTURE_MVP.md`.  
**Motivo:** separar responsabilidades, facilitar pruebas y permitir futuras ampliaciones sin introducir dependencia de servicios remotos.

### DEC-026 — Unidades, edad y edición de rutinas

**Estado:** aceptada  
**Fecha:** 2026-10-03  
**Decisión:** almacenar internamente el peso en kilogramos y las medidas en centímetros. El usuario podrá elegir kg o lb desde la configuración inicial y cambiarlo posteriormente. La edad será opcional y no existirá una edad mínima obligatoria para usar la aplicación. Las rutinas del usuario podrán modificarse libremente; las rutinas oficiales se personalizarán mediante copias editables.  
**Motivo:** evitar bloqueos innecesarios, conservar datos consistentes y permitir flexibilidad sin alterar el contenido oficial.

### DEC-027 — Valores iniciales de progresión

**Estado:** aceptada  
**Fecha:** 2026-10-03  
**Decisión:** una sesión exitosa requiere al menos 90 % completado, esfuerzo de 1 a 7, ausencia de molestia y estado completado. Después de tres sesiones exitosas consecutivas se aumentará una repetición por serie o cinco segundos. Después de otro ciclo se reducirá el descanso en cinco segundos y, después de otro ciclo, se podrá cambiar a una variante más difícil. Solo se aplicará una modificación por ciclo. Una molestia leve bloqueará la progresión; dos sesiones consecutivas de bajo rendimiento permitirán reducir el volumen o la variante.  
**Motivo:** aplicar una progresión gradual, explicable y prudente.

### DEC-028 — Backup local

**Estado:** aceptada  
**Fecha:** 2026-10-03  
**Decisión:** incluir exportación e importación manual de los datos del usuario mediante un archivo local versionado. La importación inicial reemplazará transaccionalmente el perfil local después de validar el archivo y solicitar confirmación explícita.  
**Motivo:** reducir el riesgo de pérdida de datos sin introducir servidores ni cuentas.

### DEC-029 — Medidas y contenido inicial

**Estado:** aceptada  
**Fecha:** 2026-10-03  
**Decisión:** registrar peso, cintura, cadera, pecho, brazo y muslo como medidas corporales iniciales. El contenido de ejercicios se basará en fuentes online documentadas y no requerirá una revisión profesional obligatoria antes de su integración, manteniendo advertencias de seguridad y evitando diagnósticos.  
**Motivo:** permitir un registro doméstico consistente y avanzar con el contenido disponible sin depender de conexión durante el uso.

### DEC-030 — Horarios y objetivo Android inicial

**Estado:** aceptada como propuesta técnica  
**Fecha:** 2026-10-03  
**Decisión:** usar como valores predeterminados entrenamiento a las 18:00 en los días seleccionados, peso y medidas los domingos a las 09:00, resumen semanal los domingos a las 20:00 y aviso de progresión inmediatamente después de la sesión correspondiente. Se propone Android API 26 o superior como objetivo inicial, sujeto a validación al crear el proyecto y comprobar compatibilidad con Flutter y notificaciones locales.  
**Motivo:** ofrecer horarios razonables y una base Android moderna sin cerrar todavía la compatibilidad definitiva del proyecto.

### DEC-031 — Base Flutter Android

**Estado:** implementada

**Fecha:** 2026-10-03

**Decisión:** iniciar el proyecto `casafit` para Android con Flutter 3.47.6 y Dart 3.13.5, identificador provisional `com.casafit.casafit`, Android mínimo API 26 y compilación API 37. La base incluye Material 3, cinco destinos GoRouter, ProviderScope de Riverpod y esquema Drift/SQLite versión 1 con la tabla `app_metadata`. Se agregan `drift_dev` y `build_runner` como herramientas de generación. El SDK Flutter local se guarda en `.toolchain/` y queda fuera de Git.

**Motivo:** disponer de una base Android compilable, con arquitectura y persistencia verificables, antes de desarrollar las funcionalidades del MVP. El identificador Android y la compatibilidad del futuro plugin de notificaciones deberán validarse antes de publicar.

### DEC-032 — Perfil local y configuración inicial

**Estado:** implementada

**Fecha:** 2026-10-05

**Decisión:** permitir crear y editar un único perfil local con objetivo, nivel, días concretos, duración preferida de 15 a 45 minutos y unidad de peso. La duración inicial visible es 30 minutos y la unidad inicial es kg. Nombre, edad, altura y peso inicial son opcionales. El peso se convierte y guarda en kg, aunque el usuario elija lb. El formulario se abre desde Inicio o Perfil sin bloquear la navegación principal; los datos obligatorios se exigirán para crear un plan cuando esa funcionalidad exista. Drift pasa a esquema versión 2 con `user_profiles`, `user_preferences` y `profile_available_days`, mediante una migración desde la versión 1 probada.

**Motivo:** completar una primera funcionalidad local y editable sin impedir que la persona explore la aplicación antes de configurar un plan.

### DEC-033 — Biblioteca local de ejercicios

**Estado:** implementada parcialmente; imágenes locales pendientes

**Fecha:** 2026-10-05

**Decisión:** generar un asset JSON versionado desde `EXERCISE_CATALOG.md` y `EXERCISE_INSTRUCTIONS.md`, cargar sus 60 ejercicios en Drift de forma idempotente y separar `catalogVersion` de `schemaVersion`. El esquema SQLite pasa a versión 3 con migración desde las versiones anteriores. La biblioteca ofrece búsqueda por nombre y filtros por categoría y dificultad en una hoja inferior; el detalle muestra prescripción, ejecución, respiración, seguridad y variantes. Los ejercicios de alto impacto señalan su variante fácil como alternativa. Hasta incorporar las imágenes locales se muestra un marcador de posición explícito.

**Motivo:** hacer consultable el contenido aprobado sin conexión y preparar su uso posterior en rutinas, manteniendo la fase de imágenes pendiente según DEC-018.

### DEC-034 — Rutinas oficiales locales

**Estado:** consulta implementada; inicio de sesión pendiente

**Fecha:** 2026-10-05

**Decisión:** distribuir 12 plantillas oficiales sin equipamiento, una por cada combinación de los cuatro objetivos y los tres niveles. Cada plantilla incluye duración estimada, advertencia de seguridad y ejercicios en orden con series, repeticiones o segundos, y descanso sugerido. Su contenido se genera como asset local versionado a partir de los IDs del catálogo de ejercicios y se carga en Drift como plantillas no editables. SQLite pasa a esquema versión 4 con `routines` y `routine_exercises`; `routineCatalogVersion` es independiente de la versión del esquema y del catálogo de ejercicios. La pantalla Rutinas permite filtrar por objetivo y nivel, consultar el detalle y abrir las instrucciones de cada ejercicio. El inicio de sesiones y las copias editables se desarrollarán en los siguientes incrementos.

**Motivo:** ofrecer una selección inmediata y estable de rutinas, preservar las plantillas oficiales y preparar la futura ejecución y personalización sin alterar el contenido de referencia.

