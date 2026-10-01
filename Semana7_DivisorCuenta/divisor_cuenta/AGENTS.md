# Divisor de cuenta

Esta app Flutter de una sola pantalla divide una cuenta entre varias personas.

## Estructura y dependencias

- Organiza el código en `lib/presentation`, `lib/domain` y `lib/data`.
- Las dependencias siguen `presentation -> domain <- data`.
- `lib/domain` es Dart puro y no importa `package:flutter`.
- `lib/main.dart` es el único punto que instancia implementaciones concretas.

## Estándares

Usa null safety, nombres en español y no agregues paquetes externos.

## Límites

- No modifiques `test/` sin que te lo pidan.
- No agregues dependencias a `pubspec.yaml` sin avisar.
- No modifiques `android/` ni `ios/`.

## Comandos

- `flutter pub get`
- `flutter run`
- `flutter analyze`
- `flutter test`
