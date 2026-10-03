# AceroFit — Especificación UX/UI del MVP

**Estado:** propuesta para diseño detallado  
**Fecha:** 2026-10-03  
**Documento relacionado:** [PROJECT.md](PROJECT.md)  
**Nombre de trabajo:** AceroFit  
**Posicionamiento:** entrenamiento en casa, gratis, sin anuncios, sin internet y sin equipamiento.

## 1. Principios de diseño

- La persona debe poder empezar su entrenamiento en pocos toques.
- Durante el ejercicio, la interfaz debe entenderse a distancia y con poca interacción.
- La información debe estar disponible sin internet.
- Cada recomendación del sistema experto debe ser comprensible.
- El progreso debe motivar sin exagerar ni emitir diagnósticos médicos.
- El diseño debe sentirse humano, sobrio y de producto terminado; evitar exceso de degradados, tarjetas, ilustraciones decorativas o textos genéricos.
- La aplicación debe ser completamente gratuita y no incluir publicidad.

## 2. Nombre y dirección de marca

`AceroFit` es el nombre de trabajo. Evoca fuerza, resistencia y entrenamiento, y permite una referencia energética al imaginario de “acero” sin copiar la identidad de Max Steel.

Alternativas para validar antes de cerrar la marca:

- Acero en Casa
- Modo Acero
- Fuerza Acero
- Acero Activo
- Núcleo Fit

La decisión final requiere revisar disponibilidad en Google Play, dominio, redes sociales y posibles conflictos de marca. El beneficio “gratis y sin anuncios” debe aparecer como mensaje de producto, no necesariamente en el nombre.

## 3. Arquitectura de información

La navegación principal tendrá cinco destinos: Inicio, Rutinas, Ejercicios, Progreso y Perfil. La sesión activa será una experiencia de pantalla completa; la barra inferior no aparecerá mientras el usuario entrena.

## 4. Personalización de rutinas

- Las rutinas oficiales serán plantillas protegidas.
- El usuario podrá crear una rutina propia.
- El usuario podrá personalizar una rutina oficial mediante una copia editable.
- Una copia personalizada mostrará su origen y dejará claro que el original no fue modificado.
- El usuario podrá ajustar ejercicios, orden, repeticiones, duración y descansos dentro de límites razonables.
- Las progresiones automáticas se aplicarán al plan o rutina correspondiente, no silenciosamente a todas las copias.

## 5. Datos del primer uso

### Obligatorios para crear un plan

- Objetivo.
- Nivel.
- Días concretos disponibles de la semana.
- Duración preferida entre 15 y 45 minutos.
- Unidad de peso.

La unidad inicial será kilogramo, con posibilidad de cambiar a libras inmediatamente.

### Recomendados pero opcionales

- Edad.
- Altura.
- Peso inicial.
- Medidas corporales.

La interfaz explicará que completar más datos mejora las gráficas y el seguimiento, pero no impedirá comenzar a entrenar. Debe existir un indicador discreto de “perfil incompleto”.

## 6. Registro de medidas

El MVP permitirá registrar medidas corporales con fecha. Como base se contemplan cintura, cadera, pecho, brazo y muslo. Todas serán opcionales y podrán registrarse en distintos momentos.

## 7. Seguridad y molestias

Durante la sesión debe existir una acción accesible para pausar y detenerse. En el resumen se preguntará:

- Sin molestia.
- Molestia leve.
- Dolor o necesito detenerme.

Si el usuario indica dolor, la app debe detener la progresión automática y mostrar un mensaje prudente: “Escucha a tu cuerpo. Si el dolor continúa, detén el ejercicio y considera consultar a un profesional de salud.” No debe diagnosticar ni clasificar lesiones.

## 8. Sistema experto: comunicación de rendimiento

El usuario no tendrá que configurar manualmente qué significa bajo rendimiento. La aplicación lo explicará con mensajes breves:

- Menos del 90% de la sesión completada.
- Esfuerzo registrado entre 8 y 10.
- Dolor o molestia reportada.
- Dos sesiones consecutivas con bajo rendimiento.

En esos casos se mostrará “Mantendremos la dificultad” o “Reduciremos la dificultad para la próxima sesión”, junto con la causa.

## 9. Identidad visual

### Paleta base

La dirección visual será verde tipo acero: energética, tecnológica y sobria.

| Uso | Color | Hex sugerido |
|---|---|---|
| Primario | Verde acero | `#087F7B` |
| Primario oscuro | Verde profundo | `#05605D` |
| Primario claro | Verde menta controlado | `#74C7BE` |
| Acento | Naranja energía | `#F28C28` |
| Fondo claro | Gris frío | `#F5F7F7` |
| Superficie | Blanco | `#FFFFFF` |
| Texto | Carbón azulado | `#17212B` |
| Texto secundario | Gris pizarra | `#65717D` |
| Error | Rojo sobrio | `#C94040` |

El verde dominará la navegación, los botones principales y los indicadores de avance. El naranja se reservará para progreso, energía o estados destacados.

### Tratamiento visual

- Superficies limpias y sombras suaves.
- Bordes discretos, no excesivamente redondeados.
- Iconografía Material 3 consistente.
- Imágenes de ejercicios con encuadre uniforme y fondo local coherente.
- Degradados solo en zonas hero muy concretas.
- Espaciado amplio y jerarquía clara.

### Tipografía

- Roboto como primera opción.
- Títulos semibold.
- Texto regular.
- Temporizadores bold y grandes.
- Jerarquía basada en tamaño, peso y espacio, no solo en color.

## 10. Componentes principales

- Botón primario lleno: una acción principal por pantalla.
- Botón tonal: acción secundaria relacionada.
- Botón de texto: acción de baja prioridad.
- Tarjeta de rutina: duración, nivel, objetivo y acción.
- Tarjeta de métrica: un valor y su contexto.
- Lista simple para ejercicios e historial.
- Hoja inferior para filtros.
- Modal para confirmaciones importantes.
- Barra de progreso con texto equivalente.
- Selector segmentado para periodos y categorías.

## 11. Sesión activa

La pantalla de ejercicio debe mostrar el ejercicio actual y su posición, utilizar un temporizador grande, mostrar repeticiones o segundos objetivo, mantener “Terminé” y “Pausar” visibles, ofrecer sonido y vibración configurables, mostrar el siguiente ejercicio, permitir omitir o ajustar descansos y recuperar la sesión si la app se cierra accidentalmente.

El resumen final solicitará esfuerzo de 1 a 10, molestias y notas antes de guardar definitivamente.

## 12. Estados, errores y confirmaciones

Todos los módulos deben diseñar desde el inicio estado vacío, carga local, error de almacenamiento, filtros sin resultados, datos insuficientes para una gráfica, confirmación de guardado, confirmación de borrado y sesión pausada.

Los errores deben decir qué ocurrió y qué puede hacer la persona. Nunca deben dejar la pantalla en blanco ni cerrar silenciosamente la aplicación.

## 13. Accesibilidad

- Objetivos táctiles de al menos 48 dp.
- Contraste adecuado en modo claro y oscuro.
- Soporte para texto ampliado.
- Etiquetas semánticas para lectores de pantalla.
- Información textual equivalente para temporizadores y gráficas.
- No usar el color como único indicador.
- No depender solo de sonido o vibración.
- Mensajes en español claro.
- Botón Atrás consistente.

## 14. Modo oscuro

El modo oscuro utilizará superficies gris carbón, no negro absoluto. El verde acero se aclarará para conservar contraste. Las gráficas, temporizadores y estados de error deben revisarse por separado; no basta con invertir colores automáticamente.

## 15. Decisiones pendientes

- Validar nombre definitivo y disponibilidad de `AceroFit`.
- Confirmar límites de personalización de rutinas.
- Revisar textos finales de seguridad para molestias y dolor.
- Validar reglas de bajo rendimiento con el responsable técnico.
- Definir medidas corporales finales.
- Definir horarios predeterminados de recordatorios.
- Confirmar comportamiento de Android para permiso de notificaciones y optimización de batería.

## 16. Orden recomendado de diseño e implementación

1. Tema claro/oscuro, colores, tipografía y componentes base.
2. Navegación y estructura de rutas.
3. Configuración inicial, perfil y unidades.
4. Inicio y plan personalizado.
5. Biblioteca y detalle de ejercicios.
6. Rutinas oficiales y rutinas creadas por el usuario.
7. Preparación y sesión activa.
8. Resumen e historial de sesiones.
9. Peso, medidas y progreso.
10. Reglas de progresión y explicaciones.
11. Recordatorios y notificaciones.
12. Borrado individual y borrado total.
13. Revisión de accesibilidad y prueba durante ejercicio real.
