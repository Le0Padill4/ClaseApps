# Feature Specification: Divisor de cuenta

**Feature Branch**: `001-divisor-cuenta`

**Created**: 2026-10-01

**Status**: Approved

**Input**: Una app offline de una pantalla que recibe monto, personas y propina,
permite elegir redondeo exacto o hacia arriba al entero y muestra el valor por persona.

## User Scenarios & Testing

### User Story 1 - Dividir una cuenta (Priority: P1)

Como persona que comparte una cuenta de restaurante, ingreso el monto total, el
número de personas y el porcentaje de propina, elijo el redondeo y calculo cuánto
paga cada persona.

**Why this priority**: Es el propósito completo de la aplicación.

**Independent Test**: Ingresar los valores de los seis escenarios y comprobar el
resultado o mensaje indicado, sin conexión de red.

**Acceptance Scenarios**:

1. **Given** monto 100.00, 4 personas, 10% de propina y modo exacto, **When** calculo, **Then** cada persona paga 27.50.
2. **Given** monto 90.00, 3 personas, 0% de propina y modo exacto, **When** calculo, **Then** cada persona paga 30.00.
3. **Given** monto 50.00 y 0 personas, **When** calculo, **Then** aparece `Debe haber al menos una persona` y no se muestra resultado.
4. **Given** el monto `abc`, **When** calculo, **Then** aparece `Monto inválido`.
5. **Given** monto 10.00, 3 personas, 0% de propina y modo exacto, **When** calculo, **Then** cada persona paga 3.33.
6. **Given** monto 10.00, 3 personas, 0% de propina y modo hacia arriba, **When** calculo, **Then** cada persona paga 4.00.

### Edge Cases

- Si hay cero personas, se informa el error y no se muestra un resultado anterior.
- Si el monto no es numérico, se informa `Monto inválido` y no se muestra resultado.
- El cálculo exacto presenta dos decimales; el modo hacia arriba lleva el valor por persona al entero siguiente cuando tiene fracción.

## Requirements

### Functional Requirements

- **FR-001**: El usuario puede ingresar monto total, número de personas y porcentaje de propina en una sola pantalla.
- **FR-002**: El usuario puede seleccionar redondeo exacto o hacia arriba al entero.
- **FR-003**: El cálculo suma la propina porcentual al total antes de dividir por el número de personas.
- **FR-004**: En modo exacto, el valor por persona se muestra con dos decimales.
- **FR-005**: En modo hacia arriba, el valor por persona se redondea hacia el entero siguiente.
- **FR-006**: Cero personas produce el mensaje `Debe haber al menos una persona` y no produce resultado.
- **FR-007**: Un monto no numérico produce el mensaje `Monto inválido` y no produce resultado.
- **FR-008**: La aplicación realiza todos los cálculos localmente, sin red ni base de datos.

### Key Entities

- **Cuenta**: monto total, cantidad de personas y porcentaje de propina.
- **Resultado**: monto que paga cada persona luego de aplicar propina y redondeo.
- **Estrategia de redondeo**: regla seleccionada para convertir el valor calculado por persona.

## Success Criteria

### Measurable Outcomes

- **SC-001**: Los seis escenarios de aceptación producen exactamente el resultado o mensaje especificado.
- **SC-002**: Las entradas inválidas nunca muestran un resultado calculado.
- **SC-003**: La tarea se completa desde una sola pantalla, sin red y sin guardar datos.
- **SC-004**: Cada uno de los seis escenarios puede verificarse de manera repetible mediante pruebas.

## Assumptions

- La propina es un porcentaje del monto total y se reparte entre las personas.
- El modo exacto muestra dos decimales; el modo hacia arriba devuelve el entero siguiente por persona, como demuestra el escenario 6.
- No se requiere persistencia, historial, autenticación, conexión de red ni más pantallas.
