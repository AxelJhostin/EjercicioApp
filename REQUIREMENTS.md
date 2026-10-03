# CasaFit — Requisitos del MVP

**Estado:** propuesta aprobada para diseño detallado  
**Fecha:** 2026-10-02  
**Documento relacionado:** [PROJECT.md](PROJECT.md)

Este documento define el alcance funcional del MVP. `PROJECT.md` conserva las decisiones centrales del proyecto; cualquier cambio de alcance debe reflejarse en ambos documentos.

## 1. Usuario inicial

Persona adulta que desea entrenar en casa sin equipamiento, principalmente principiante o intermedia, con acceso a un teléfono Android. Busca una guía clara, registrar sus sesiones, ver avances y recibir recordatorios. Puede tener conectividad limitada, por lo que las funciones principales deben operar sin internet.

El MVP contempla un único perfil local por instalación, sin cuenta ni servidor.

## 2. Problema y propuesta de valor

El usuario no siempre sabe qué ejercicios hacer, cómo aumentar progresivamente la dificultad ni cómo medir si está mejorando. CasaFit ofrecerá rutinas preprogramadas y planes personalizados generados por un sistema experto de reglas, acompañados de temporizadores, recordatorios, registro local y métricas de progreso.

El sistema experto no utilizará inteligencia artificial ni servicios externos. Sus recomendaciones serán explicables, deterministas y basadas en objetivo, nivel, disponibilidad, historial, rendimiento y respuesta del usuario.

## 3. Objetivos del MVP

- Permitir completar entrenamientos de peso corporal sin conexión.
- Ofrecer rutinas preprogramadas y planes personalizados.
- Adaptar progresivamente la dificultad según reglas verificables.
- Registrar sesiones, repeticiones, duración, descansos, esfuerzo y notas.
- Mostrar avances mediante historial, gráficas y métricas comprensibles.
- Ayudar a mantener la constancia mediante notificaciones y recordatorios programados.
- Mantener todos los datos del usuario localmente y permitir su eliminación segura.

## 4. Alcance incluido

### Perfil y configuración

- Datos básicos, objetivo, nivel y días disponibles.
- Preferencias de unidades seleccionables.
- Unidad inicial recomendada: peso en kilogramos y medidas en centímetros; el usuario puede cambiar el peso a libras.
- Edición del perfil y preferencias.

### Ejercicios

- Biblioteca local de ejercicios sin equipamiento.
- Clasificación por grupo muscular, tipo y dificultad.
- Imágenes locales del ejercicio.
- Instrucciones, recomendaciones de seguridad y variantes.

### Rutinas y planes

- Rutinas preprogramadas obligatorias.
- Creación de rutinas propias y personalización de rutinas preprogramadas mediante copias editables.
- Creación de planes personalizados mediante un sistema experto de reglas.
- Selección de objetivo, nivel, días disponibles y duración.
- Progresión adaptativa de dificultad, volumen, repeticiones, tiempo o descansos.
- Explicación sencilla de por qué se recomienda una progresión.

### Entrenamiento

- Inicio, pausa, reanudación y finalización de sesiones.
- Temporizador de ejercicio.
- Temporizador de descanso entre ejercicios.
- Sonido y vibración configurables durante la sesión.
- Registro de repeticiones, duración, esfuerzo y notas.
- Resumen al terminar.

### Progreso

- Historial de entrenamientos.
- Peso y medidas por fecha.
- Sesiones completadas, rachas, tiempo total y rendimiento.
- Mejores marcas por ejercicio cuando existan datos suficientes.
- Gráficas básicas de peso, constancia y evolución por ejercicio.

### Notificaciones

- Recordatorios programados de entrenamiento.
- Notificación de sesión pendiente o próxima.
- Recordatorio configurable para registrar peso o medidas.
- Avisos de progreso o de nueva progresión disponible.
- Configuración para activar, desactivar y modificar horarios.
- Funcionamiento local, sin servidor ni notificaciones remotas.

### Privacidad y datos

- Persistencia local con SQLite mediante Drift.
- Eliminación de registros individuales.
- Eliminación completa de datos desde ajustes.
- Triple confirmación antes del borrado total:
  1. Aviso explícito de que la acción es irreversible.
  2. Confirmación separada del usuario.
  3. Confirmación final mediante acción consciente, por ejemplo escribir `BORRAR`.

## 5. Fuera del MVP

- Inicio de sesión, cuentas y sincronización.
- Servidor o base de datos remota.
- Sistema experto conectado a servicios externos.
- Inteligencia artificial generativa.
- Red social, comunidad o chat con entrenadores.
- Pagos, suscripciones y publicidad.
- Integración con relojes, sensores o plataformas de salud.
- Ejercicios con pesas, bandas o máquinas.
- Videos en streaming.
- Compartir resultados en redes sociales.
- Múltiples perfiles por dispositivo.

## 6. Historias de usuario principales

- Como usuario, quiero configurar mi objetivo, nivel, disponibilidad y unidades para recibir una experiencia adecuada.
- Como usuario, quiero consultar ejercicios con imágenes e instrucciones para ejecutarlos correctamente.
- Como usuario, quiero elegir una rutina preprogramada para empezar a entrenar rápidamente.
- Como usuario, quiero recibir un plan personalizado basado en reglas claras y en mi progreso.
- Como usuario, quiero que el plan aumente gradualmente la dificultad cuando mi rendimiento lo permita.
- Como usuario, quiero que el plan reduzca o mantenga la dificultad si mi rendimiento indica que todavía no estoy preparado.
- Como usuario, quiero usar temporizadores de ejercicio y descanso durante la sesión.
- Como usuario, quiero registrar repeticiones, tiempo, esfuerzo y notas.
- Como usuario, quiero consultar mis avances y resultados históricos.
- Como usuario, quiero programar recordatorios para mantener la constancia.
- Como usuario, quiero borrar todos mis datos con varias confirmaciones para evitar errores.

## 7. Requisitos funcionales y prioridades

| ID | Requisito | Prioridad |
|---|---|---|
| RF-01 | Crear y editar un perfil local | Crítica |
| RF-02 | Configurar objetivo, nivel, disponibilidad y unidades | Crítica |
| RF-03 | Consultar biblioteca local de ejercicios con imágenes | Crítica |
| RF-04 | Filtrar ejercicios por categoría y dificultad | Alta |
| RF-05 | Consultar instrucciones, variantes y seguridad | Crítica |
| RF-06 | Consultar rutinas preprogramadas | Crítica |
| RF-07 | Crear un plan personalizado con reglas del sistema experto | Crítica |
| RF-08 | Explicar los criterios básicos de la recomendación | Alta |
| RF-09 | Adaptar progresivamente el plan según el historial | Crítica |
| RF-10 | Iniciar, pausar, reanudar y finalizar sesiones | Crítica |
| RF-11 | Temporizar ejercicio y descanso | Crítica |
| RF-12 | Registrar repeticiones, tiempo, esfuerzo y notas | Crítica |
| RF-13 | Guardar todos los datos localmente | Crítica |
| RF-14 | Consultar historial de sesiones | Alta |
| RF-15 | Registrar peso y medidas | Alta |
| RF-16 | Mostrar métricas y gráficas de progreso | Alta |
| RF-17 | Crear y editar recordatorios programados | Alta |
| RF-18 | Mostrar notificaciones locales de entrenamiento y progreso | Alta |
| RF-19 | Borrar registros individuales | Alta |
| RF-20 | Borrar todos los datos con triple confirmación | Crítica |
| RF-21 | Funcionar completamente sin internet | Crítica |

## 8. Criterios de aceptación

### Perfil y preferencias

- El usuario puede crear y editar un único perfil local.
- Objetivo, nivel, disponibilidad y unidades se guardan y reaparecen al reiniciar la aplicación.
- El usuario puede seleccionar kilogramos o libras para peso y centímetros para medidas; kilogramos será la opción inicial.
- Los valores inválidos muestran mensajes claros y no se guardan.

### Biblioteca de ejercicios

- Todos los ejercicios iniciales están disponibles sin internet.
- Cada ejercicio contiene nombre, imagen local, instrucciones, dificultad y recomendaciones de seguridad.
- Se puede filtrar por grupo muscular, tipo y dificultad.
- Cada ejercicio ofrece variantes más fáciles o difíciles cuando estén definidas.

### Rutinas preprogramadas

- Existen rutinas para los objetivos y niveles definidos.
- Cada rutina indica duración, ejercicios, orden, repeticiones o tiempos y descansos.
- Ninguna rutina del MVP requiere equipamiento.
- El usuario puede iniciar una rutina desde su detalle.

### Sistema experto y plan personalizado

- El usuario puede solicitar un plan personalizado sin conexión.
- El sistema utiliza reglas documentadas y deterministas, no IA ni red.
- La recomendación considera como mínimo objetivo, nivel, días disponibles, duración y rendimiento histórico.
- El sistema no recomienda ejercicios incompatibles con las restricciones configuradas.
- La aplicación muestra una explicación breve de los factores usados.
- Si faltan datos, se solicitan únicamente los datos necesarios o se aplican valores predeterminados explícitos.

### Progresión adaptativa

- Después de una sesión completada, el sistema evalúa los datos registrados.
- La dificultad puede aumentar mediante progresiones definidas: más repeticiones, más tiempo, menos descanso o variante avanzada.
- La progresión solo ocurre después de completar correctamente varias sesiones consecutivas, según reglas de desempeño previamente definidas.
- Si el rendimiento empeora, el usuario no completa sesiones o reporta esfuerzo excesivo, el sistema puede mantener o reducir la dificultad.
- Toda progresión queda registrada y puede consultarse.
- Nunca se aumenta la dificultad de forma automática sin respetar límites de seguridad definidos.

### Sesión y temporizadores

- El usuario puede iniciar, pausar, reanudar y terminar una sesión.
- El temporizador muestra el tiempo restante de ejercicio o descanso.
- El descanso comienza al completar el ejercicio cuando la rutina lo indique.
- El usuario puede omitir o ajustar un descanso durante la sesión.
- Al finalizar, se presenta un resumen antes de guardar definitivamente.
- Una sesión abandonada no se registra como completada.

### Registro e historial

- Se pueden registrar repeticiones, tiempo, descanso, esfuerzo y notas.
- Los datos quedan asociados al ejercicio y a la sesión correcta.
- El historial se ordena por fecha y distingue sesiones completadas y abandonadas.
- Los datos permanecen tras cerrar la aplicación y reiniciar el dispositivo.

### Progreso

- El usuario puede registrar peso y medidas con fecha.
- Las gráficas muestran datos en orden temporal y respetan la unidad seleccionada.
- Se muestran sesiones completadas, tiempo total, constancia y rendimiento.
- No se muestran conclusiones cuando no existen datos suficientes.
- Las métricas se recalculan después de guardar una sesión o medición.

### Notificaciones y recordatorios

- El usuario puede crear, editar, activar, desactivar y eliminar recordatorios.
- El recordatorio de entrenamiento, el aviso de nueva progresión y el resumen semanal estarán activos inicialmente con valores predeterminados editables.
- Puede seleccionar días y hora.
- Los recordatorios se generan localmente y no dependen de internet.
- El usuario puede posponer una notificación.
- El usuario puede desactivar todas las notificaciones.
- La aplicación solicita los permisos de Android necesarios de forma clara.
- No se envían notificaciones si el usuario las desactiva.

### Borrado de datos

- El usuario puede borrar registros individuales con confirmación.
- El borrado total explica que es irreversible.
- El borrado total requiere tres confirmaciones independientes.
- La tercera confirmación requiere una acción consciente, como escribir `BORRAR`.
- Después del borrado, no quedan perfil, sesiones, mediciones, planes ni preferencias del usuario.
- La aplicación queda en un estado inicial funcional.

## 9. Requisitos no funcionales

| ID | Requisito | Prioridad |
|---|---|---|
| RNF-01 | Las funciones principales deben operar sin internet | Crítica |
| RNF-02 | Los datos del usuario deben permanecer localmente | Crítica |
| RNF-03 | La aplicación debe conservar los datos tras reinicios | Crítica |
| RNF-04 | La lógica del sistema experto debe ser testeable y explicable | Crítica |
| RNF-05 | Las reglas de progresión deben estar separadas de la interfaz | Alta |
| RNF-06 | Las notificaciones deben usar mecanismos locales de Android | Alta |
| RNF-07 | La aplicación debe seguir Material 3 y soportar accesibilidad básica | Alta |
| RNF-08 | La interfaz y mensajes iniciales deben estar en español | Alta |
| RNF-09 | El contenido visual debe estar disponible localmente | Alta |
| RNF-10 | Deben existir pruebas unitarias, de interfaz y de persistencia | Alta |
| RNF-11 | Los errores de almacenamiento no deben cerrar silenciosamente la aplicación | Alta |
| RNF-12 | La estructura debe permitir añadir sincronización en el futuro | Media |
| RNF-13 | No deben almacenarse datos médicos innecesarios | Crítica |

## 10. Riesgos y supuestos

### Riesgos

- Un sistema experto mal calibrado puede recomendar progresiones demasiado fáciles o exigentes.
- Las recomendaciones de ejercicio pueden interpretarse como consejo médico.
- Las notificaciones pueden no mostrarse si Android restringe permisos o batería.
- El borrado total puede causar pérdida irreversible si el usuario confirma por error.
- Rutinas personalizadas, progresión y notificaciones aumentan significativamente el alcance del MVP.

### Mitigaciones

- Mantener reglas simples, documentadas y cubiertas por pruebas.
- Definir límites máximos de progresión y permitir mantener o reducir dificultad.
- Mostrar avisos de seguridad y no realizar diagnósticos.
- Usar triple confirmación y explicar el efecto del borrado.
- Implementar por incrementos y validar primero una versión pequeña del sistema experto.

### Supuestos

- El sistema experto será basado en reglas y no aprenderá automáticamente del usuario.
- El contenido de ejercicios, rutinas e imágenes se distribuirá dentro de la aplicación.
- La unidad inicial será libra para peso y centímetro para medidas, con selección futura de alternativas.
- Las notificaciones serán locales y programadas en el dispositivo.
- El usuario podrá ajustar manualmente una sesión, pero los cambios quedarán registrados.

## Decisiones de diseño aprobadas

### Progresión

- Estrategia gradual: aumentar primero 1–2 repeticiones o 5 segundos; después de varias mejoras, reducir el descanso y finalmente cambiar a una variante más difícil.
- Condición: aplicar la progresión después de completar correctamente tres sesiones consecutivas de la misma rutina o progresión.
- Solo se aplicará una modificación de progresión por ciclo para evitar aumentos bruscos.
- El esfuerzo se registrará en una escala de 1 a 10.
- Se requiere un esfuerzo de 1 a 7, al menos 90% de la sesión completada y ausencia de dolor o molestia reportada.
- Un esfuerzo de 8 a 10, una sesión incompleta o una molestia reportada impiden aumentar la dificultad.
- Dos sesiones consecutivas con bajo rendimiento pueden provocar mantenimiento o reducción de dificultad.

### Frecuencia predeterminada

- Principiante: 3 días por semana.
- Intermedio: 4 días por semana.
- Avanzado: 5 días por semana.
- El usuario podrá modificar la frecuencia dentro de los límites disponibles.

### Parámetros iniciales del plan personalizado

- Duración recomendada: entre 15 y 45 minutos por sesión.
- Máximo recomendado: 5 días de entrenamiento por semana.
- El plan incluirá calentamiento y enfriamiento básicos.
- El usuario podrá excluir ejercicios específicos.
- El sistema considerará objetivo, nivel, días disponibles, duración, intensidad preferida, exclusiones, historial, rendimiento y esfuerzo registrado.

### Notificaciones

- Las notificaciones principales estarán activas inicialmente.
- Se podrá posponer una notificación de entrenamiento o progreso.
- La frecuencia y los horarios serán editables.
- El resumen semanal se emitirá una vez por semana, en un horario configurable.

### Catálogo de ejercicios

- El catálogo inicial tendrá aproximadamente 60 ejercicios, definidos en [EXERCISE_CATALOG.md](EXERCISE_CATALOG.md).
- Incluirá calentamiento, fuerza, cardio, movilidad, flexibilidad, enfriamiento y trabajo de core.
- Se incluirán ejercicios de impacto, como saltos, siempre con advertencias y alternativas de bajo impacto cuando sea posible.
- Cada ejercicio tendrá imagen local, instrucciones, dificultad, clasificación, duración o repeticiones, descanso y variantes.
- Cada ejercicio tendrá impacto articular e intensidad como atributos separados.
- Los ejercicios con riesgo técnico específico tendrán una advertencia y una alternativa adecuada.

### Permisos de notificaciones en Android

- El permiso se solicitará después de que el usuario configure su primer recordatorio.
- Antes de solicitarlo, se explicará su utilidad.
- Si el permiso es rechazado, la aplicación seguirá funcionando y permitirá reintentarlo desde ajustes.
- Los recordatorios usarán la hora local del dispositivo.
- Se podrá posponer un recordatorio de entrenamiento 10, 30 o 60 minutos.
- Si Android restringe la entrega por batería, se mostrarán instrucciones para corregirlo.

## 11. Orden de implementación

1. Base Flutter, navegación, Material 3 y persistencia local.
2. Perfil, objetivos, preferencias y unidades.
3. Catálogo local de ejercicios e imágenes.
4. Rutinas preprogramadas.
5. Flujo de sesión y temporizadores.
6. Registro e historial de entrenamientos.
7. Peso, medidas y gráficas.
8. Motor de reglas para planes personalizados.
9. Progresión adaptativa y registro de cambios de dificultad.
10. Recordatorios y notificaciones locales.
11. Borrado individual y borrado total con triple confirmación.
12. Pruebas de funcionamiento offline, Android real, accesibilidad y regresión.

## 12. Decisiones pendientes que pueden afectar el diseño

- Definir los valores detallados de las reglas de aumento, mantenimiento y reducción de dificultad.
- Definir qué permisos y comportamiento de Android se aceptarán para las notificaciones.
- Revisar y aprobar el contenido técnico del catálogo de aproximadamente 60 ejercicios, variantes, imágenes, impacto e intensidad.
- Definir el contenido exacto de calentamientos y enfriamientos.

