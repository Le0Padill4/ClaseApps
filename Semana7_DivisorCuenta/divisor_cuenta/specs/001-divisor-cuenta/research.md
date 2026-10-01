# Research: Divisor de cuenta

## Decisiones

- Usar el SDK Flutter estable disponible (Flutter 3.47.1, Dart 3.13.1), sin dependencias adicionales.
- Mantener entidades, validación, cálculo e interfaz de redondeo en Dart puro. Flutter usa estado local con setState, suficiente para una pantalla.
- Inyectar estrategias por constructor y crear implementaciones concretas solo en main.dart.
- Redondear después de calcular (monto + propina) / personas para seguir la salida de los seis criterios.

## Razonamiento y referencias

El alcance no tiene persistencia, API o plugin. La separación permite probar el cálculo sin widgets y reemplazar una regla sin modificar el caso de uso. Flutter recomienda separar UI y datos y presenta patrones de arquitectura en [Architecture recommendations](https://docs.flutter.dev/app-architecture/recommendations) y [Architecture guide](https://docs.flutter.dev/app-architecture/guide). Las pruebas siguen [Flutter testing overview](https://docs.flutter.dev/testing/overview) y el [widget test introduction](https://docs.flutter.dev/cookbook/testing/widget/introduction).

## Alternativas consideradas

- Agregar paquetes para estado o dinero: descartado porque no son necesarios y la práctica prohíbe dependencias externas.
- Poner cálculo y validación dentro del widget: descartado porque incumple SRP, DIP y la exigencia de domain puro.
- Crear interfaces para todas las clases: descartado; solo redondeo tiene implementaciones intercambiables especificadas.
- No crear contracts/: la app no ofrece APIs ni contratos externos.
