# Tasks: Divisor de cuenta

**Input**: specs/001-divisor-cuenta/spec.md

**Prerequisites**: plan.md, spec.md, research.md, data-model.md.
**Tests**: Obligatorios: los seis escenarios, LSP y tres widget tests.

## Phase 1: Setup

- [X] T001 Usar el proyecto Flutter base y verificar flutter pub get sin añadir dependencias.
- [X] T002 Crear AGENTS.md, inicializar Spec Kit y establecer la Constitution.

## Phase 2: User Story 1 - Dividir una cuenta (P1)

**Goal**: Calcular y mostrar el pago por persona con validaciones y los dos redondeos.
**Independent Test**: Seis casos de dominio y tres flujos de pantalla.

### Tests (antes de implementar)

- [X] T003 [US1] Crear la tabla literal de seis escenarios en test/casos_de_prueba.dart.
- [X] T004 [US1] Crear pruebas parametrizadas de aceptación y sustitución LSP en test/division_test.dart.
- [X] T005 [US1] Crear los tres widget tests en test/pantalla_test.dart.

### Implementación

- [X] T006 [US1] Crear entidades Cuenta, Resultado e interfaz EstrategiaRedondeo en lib/domain/.
- [X] T007 [US1] Implementar ValidarEntrada y CalcularDivision como responsabilidades separadas en lib/domain/.
- [X] T008 [US1] Implementar RedondeoExacto y RedondeoHaciaArriba en lib/data/.
- [X] T009 [US1] Implementar DivisorController con dependencias por constructor y FormateadorMoneda en lib/presentation/.
- [X] T010 [US1] Crear PantallaDivisor y composición concreta exclusiva en lib/main.dart.

## Phase 3: Validación y comparación

- [X] T011 Ejecutar flutter test, flutter analyze y flutter build apk --debug y corregir lo necesario.
- [X] T012 Ejecutar los cuatro grep de arquitectura/SOLID definidos en la práctica y revisar su resultado.
- [ ] T013 Llevar temporalmente los tres archivos de prueba SDD a VIBE, registrar el resultado y restaurar el test/ original.

## Dependencias y orden

T001–T002 preceden la historia. T003–T005 describen las pruebas antes de T006–T010;
las clases de dominio preceden data y presentación. T011–T013 se ejecutan con el
código completo. La pantalla y el cálculo comparten el mismo contrato funcional.
