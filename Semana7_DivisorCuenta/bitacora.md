# Bitácora — Semana 7

## VIBE

Mensaje inicial usado para la implementación:

> Hazme una app en Flutter para dividir la cuenta entre varias personas.

Mensajes de corrección posteriores: 0. El template inicial generó una prueba de contador que ya no correspondía a la app; el analizador señaló su referencia rota a MyApp. Quité ese archivo para que VIBE quedara con analyze limpio. Fue una acción del agente tras el diagnóstico, no un mensaje de corrección del usuario.

## SDD

- Spec Kit 1.0.13 instalado ya disponible; uv 0.12.19, Python 3.13.13.
- Flutter 3.47.1 stable / Dart 3.13.1; flutter doctor finalizó con “No issues found!” (mostró avisos de iPhone/iPad inalámbricos no disponibles).
- Se quitaron `cupertino_icons` y `flutter_lints` heredados y no usados; el pub get final conservó solo dependencias del Flutter SDK y sus transitivas de prueba.
- Clarify: 0 preguntas relevantes; escenarios, mensajes, porcentajes y dos redondeos ya estaban especificados.
- Tareas generadas: 13; al finalizar, 13/13 completas.
- Pruebas: 10 aprobadas (6 escenarios, 1 LSP, 3 widget).
- Analyze: No issues found!
- Build Android debug: éxito. Primera compilación limpia: 189.4 s; verificación final incremental: 3.3 s.
- El primer analyze mostró cinco sugerencias de inicialización del constructor; se ajustó y el siguiente terminó sin issues.

## Pruebas temporales SDD en VIBE

La compilación falló al no encontrar lib/data/redondeo_exacto.dart. La comparación fue arquitectónica/testabilidad; luego corrí los seis flujos de la app en Chrome:

1. 100 / 4 / 10% / exacto -> 27.50.
2. 90 / 3 / 0% / exacto -> 30.00.
3. 50 / 0 -> “Debe haber al menos una persona”, sin resultado.
4. abc -> “Monto inválido”.
5. 10 / 3 / 0% / exacto -> 3.33.
6. 10 / 3 / 0% / hacia arriba -> 4.00.

Restauré test/ de VIBE al estado del commit; esa rama queda sin pruebas automatizadas.
