# Quickstart: Divisor de cuenta

## Requisitos

Flutter stable instalado y Android SDK disponible.

## Preparar

Desde `Semana7_DivisorCuenta/divisor_cuenta/`:

```sh
flutter pub get
```

No se requieren paquetes externos ni conexión en ejecución.

## Validar

```sh
flutter test
flutter analyze
flutter build apk --debug
```

El test debe cubrir los seis escenarios, sustitución LSP y tres flujos de
pantalla. En el APK, ingresar monto, personas y propina; elegir el redondeo y
pulsar **Calcular**.
