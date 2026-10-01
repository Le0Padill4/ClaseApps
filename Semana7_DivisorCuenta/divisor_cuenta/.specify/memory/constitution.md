# Divisor de cuenta Constitution

## Core Principles

### I. SRP — Responsabilidad única
Cada clase tiene una razón de cambio. El cálculo no valida entradas ni formatea
moneda; la validación, presentación y cálculo permanecen separados.

### II. OCP — Abierto/cerrado
`CalcularDivision` depende de `EstrategiaRedondeo`. Agregar otra estrategia de
redondeo no requiere modificar el cálculo ni estrategias ya existentes.

### III. LSP — Sustitución de Liskov
Cualquier implementación de `EstrategiaRedondeo` puede sustituir a otra sin
que quien calcula pregunte el tipo concreto ni haga casts.

### IV. ISP — Segregación de interfaces
`EstrategiaRedondeo` expone un único método para redondear un valor; ningún
cliente depende de operaciones que no utiliza.

### V. DIP — Inversión de dependencias
La presentación depende de abstracciones del domain. `domain` no importa
Flutter y no depende de `data`. Solo `main.dart` instancia implementaciones
concretas.

## Restricciones adicionales

- La aplicación es una sola pantalla para monto, personas, propina y resultado.
- Las capas son `presentation`, `domain` y `data`, con dependencias
  `presentation -> domain <- data`.
- `domain` es Dart puro. La app funciona sin red ni base de datos.
- No se agregan paquetes externos ni secretos al repositorio.
- Se usa null safety y nombres en español.

## Calidad y aprendizaje

- Cada criterio de aceptación tiene una prueba ejecutable; el cálculo crítico
  tiene pruebas sin widgets y la pantalla tiene pruebas de widgets.
- El proyecto debe pasar `flutter test`, `flutter analyze` y
  `flutter build apk --debug`.
- El estudiante debe poder explicar cada función generada: propósito, entradas,
  salida y errores posibles.

## Governance

Esta constitución gobierna la implementación y prevalece sobre decisiones de
plan o código que la contradigan. Todo cambio a estos principios requiere
actualizar este archivo y su versión. En cada revisión se comprueban las capas,
los cinco principios SOLID y las pruebas requeridas por la spec.

**Version**: 1.0.0 | **Ratified**: 2026-10-01 | **Last Amended**: 2026-10-01
