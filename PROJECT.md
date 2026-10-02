# Proyecto: CasaFit

Aplicación móvil para entrenar en casa sin equipamiento y registrar el progreso personal.

## 1. Estado del proyecto

**Fase actual:** descubrimiento y definición del producto  
**Estado:** en planificación  
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
- Unidades seleccionables; configuración inicial recomendada en libras y centímetros.
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

- Edad, altura y datos básicos.
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

Cada rutina tendrá objetivo, dificultad, duración aproximada, ejercicios, orden, descansos y recomendaciones de seguridad. Existirán rutinas preprogramadas y planes personalizados generados por reglas deterministas.

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

## 8. Entidades principales

- `UserProfile`
- `Goal`
- `Exercise`
- `Routine`
- `RoutineExercise`
- `WorkoutSession`
- `ExerciseRecord`
- `BodyMeasurement`
- `PersonalRecord`
- `PersonalPlan`
- `ProgressionRule`
- `AppliedProgression`
- `Reminder`

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
- [ ] Definir las pantallas principales y navegación.
- [x] Crear inventario inicial de aproximadamente 60 ejercicios, variantes e imágenes.
- [ ] Revisar y aprobar técnicamente el contenido del catálogo de ejercicios.
- [ ] Definir permisos y comportamiento de notificaciones en Android.
- [ ] Crear el proyecto Flutter.
- [ ] Diseñar el modelo inicial de SQLite.
- [ ] Implementar la primera pantalla funcional.
- [ ] Probar la instalación en Android.

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
**Decisión:** permitir seleccionar unidades; la configuración inicial recomendada es libras para peso y centímetros para medidas. Los ejercicios tendrán imágenes locales.  
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

