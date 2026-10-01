# Data Model: Divisor de cuenta

## Cuenta

- `monto`: total de la cuenta, número decimal finito.
- `personas`: cantidad entera; debe ser al menos 1.
- `porcentajePropina`: porcentaje decimal finito.
- Es inmutable durante un cálculo.

## Resultado

- `montoPorPersona`: valor numérico aplicado a la estrategia elegida.
- La presentación lo muestra con dos decimales.

## EstrategiaRedondeo

- Contrato con un único método que recibe el valor calculado por persona y
  retorna su valor redondeado.
- `RedondeoExacto`: aproxima a centavos (dos decimales).
- `RedondeoHaciaArriba`: retorna el entero superior del valor por persona.

## Relaciones y validaciones

Una `Cuenta` válida produce un `Resultado` usando una `EstrategiaRedondeo`.
La validación ocurre antes del cálculo: personas menores que uno producen
`Debe haber al menos una persona`; monto inválido o no finito produce
`Monto inválido`.
