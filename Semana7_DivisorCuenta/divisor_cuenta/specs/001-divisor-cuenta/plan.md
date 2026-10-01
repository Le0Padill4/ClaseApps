# Implementation Plan: Divisor de cuenta

**Branch**: `sdd` | **Date**: 2026-10-01 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification at `specs/001-divisor-cuenta/spec.md`.

## Summary

Implementar el mismo divisor en Flutter estable, sin paquetes externos ni
servicios. `domain` concentra entidades, validación, cálculo e interfaz de
redondeo pura en Dart; `data` aporta sus dos implementaciones; `presentation`
coordina el formulario mediante dependencias recibidas por constructor. Solo
`main.dart` crea las estrategias concretas.

## Technical Context

**Language/Version**: Dart 3.13.1 con Flutter 3.47.1 stable.

**Primary Dependencies**: Flutter SDK y `flutter_test` incluido por la plantilla Flutter; sin paquetes externos.

**Storage**: Ninguno.

**Testing**: `flutter test`, pruebas Dart de dominio y tres pruebas de widgets.

**Target Platform**: Android (APK debug); Flutter multiplataforma.

**Project Type**: Aplicación móvil de una pantalla.

**Performance Goals**: Cálculo local inmediato para una cuenta.

**Constraints**: Offline; sin red, persistencia ni dependencias externas;
`domain` no importa Flutter; respetar SOLID y el alcance de la spec.

**Scale/Scope**: Una cuenta a la vez y una pantalla.

## Constitution Check

- SRP: cálculo, validación, formato y dibujo en responsabilidades separadas.
- OCP: el caso de uso depende de `EstrategiaRedondeo`.
- LSP: exacto y hacia arriba se intercambian por la misma interfaz.
- ISP: la interfaz de redondeo tiene un solo método.
- DIP: controller depende de interfaces/casos de uso del domain; composición
  concreta solo en `main.dart`.
- Capas: `presentation -> domain <- data`; domain no importa Flutter.
- Seguridad y aprendizaje: sin credenciales/dependencias extras; las funciones
  se mantienen pequeñas y explicables.

**Gate inicial**: PASS. La especificación, plan y constitución son compatibles.

## Project Structure

```text
lib/
├── domain/
│   ├── cuenta.dart
│   ├── resultado.dart
│   ├── estrategia_redondeo.dart
│   ├── calcular_division.dart
│   └── validar_entrada.dart
├── data/
│   ├── redondeo_exacto.dart
│   └── redondeo_hacia_arriba.dart
├── presentation/
│   ├── divisor_controller.dart
│   ├── formateador_moneda.dart
│   └── pantalla_divisor.dart
└── main.dart

test/
├── casos_de_prueba.dart
├── division_test.dart
└── pantalla_test.dart
```

**Structure Decision**: Un único proyecto Flutter. No hay API, contratos de red,
datos persistentes ni carpeta `contracts/` que diseñar.

## Design Decisions

- `Cuenta` conserva total, personas y porcentaje; `Resultado` representa el
  valor por persona.
- `ValidarEntrada` devuelve mensaje nullable y se ejecuta antes del cálculo.
- `CalcularDivision` recibe `Cuenta` y `EstrategiaRedondeo`; primero reparte
  total más propina y después aplica la estrategia.
- El redondeo exacto expresa centavos a dos decimales; la estrategia hacia
  arriba lleva el valor por persona al siguiente entero.
- El controller recibe validador, caso de uso y estrategias por constructor.
  Flutter `setState` conserva el estado de la pantalla.
- Las pruebas de dominio recorren la tabla compartida de seis casos y prueban
  sustitución LSP; las tres pruebas de widgets verifican resultado y errores.

**Gate posterior al diseño**: PASS. Las decisiones mantienen las restricciones
SOLID y hacen comprobables los seis escenarios.
