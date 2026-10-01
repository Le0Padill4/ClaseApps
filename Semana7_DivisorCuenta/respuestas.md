# Respuestas — Semana 7: Vibe coding vs. SDD

## Alcance y Git

El proyecto vive en `Semana7_DivisorCuenta/divisor_cuenta/`. El repositorio ya tenía trabajos previos y cambios locales sin guardar, así que trabajé en un worktree separado basado en `main`. Las ramas globales `vibe` y `sdd` no existían ni en local ni en GitHub; se pudieron crear sin sobrescribir trabajos.

El proyecto Flutter base quedó en el commit común `67cd8e6`. Tanto `vibe` como `sdd` parten de ese mismo commit. En ambas ramas quité `cupertino_icons` y `flutter_lints`, que venían sin uso en la plantilla, para cumplir el requisito de no incorporar paquetes externos; las dependencias directas restantes son Flutter SDK y flutter_test del SDK. La carpeta es nueva y no contiene cambios a las prácticas anteriores. `respuestas.md` está en esta rama `main`; el código final de cada enfoque se ve al cambiar a su rama.

Agente: Codex con integración CLI de Spec Kit. Spec Kit 1.0.13, uv 0.12.19, Python 3.13.13, Flutter 3.47.1 stable y Dart 3.13.1. El modelo fue GPT-6 de esta sesión y usé la configuración predeterminada. La variante exacta del modelo y el nivel de razonamiento no estuvieron expuestos en la interfaz; por eso no los invento. Se usó la misma sesión para las dos variantes.

En VIBE, el mensaje inicial de implementación fue: “Hazme una app en Flutter para dividir la cuenta entre varias personas.” No envié mensajes de corrección después. En SDD, las etapas de Spec Kit son pasos planeados, no iteraciones de corrección. La indicación general de esta tarea ya incluía la guía y sus seis escenarios, así que el contexto completo sí estaba disponible mientras se construía VIBE. Por eso esta ejecución no fue un experimento a ciegas ni una comparación científica.

| Métrica | VIBE | SDD |
|---|---:|---:|
| Iteraciones (mensajes de corrección después del inicio) | 0 | 0 |
| Escenarios cumplidos | 6/6, comprobados manualmente en Chrome | 6/6, comprobados en pruebas |
| Pruebas automatizadas que pasan | 0; la rama queda sin pruebas automatizadas | 10: seis escenarios, LSP y tres widget tests |
| Archivos Dart en `lib/` | 1 | 11 |
| Líneas en `lib/` | 119 | 253 |
| `domain/` depende de Flutter | No existe `domain/`; toda la app está en `main.dart` | No |
| Separación `presentation/domain/data` | No | Sí |
| Algo no solicitado | No se añadió otra función; los dos redondeos se requieren para cubrir los escenarios 5 y 6 | Se añadió un mensaje específico “Propina inválida”; la guía no lo exige como escenario |
| Se puede añadir un redondeo sin cambiar el cálculo existente | No hay un cálculo aislado | Sí, se añade una implementación; para ofrecerla en pantalla también se actualiza la selección y el punto de composición |

No medí el tiempo hasta completar los escenarios.

## 1. Cumplimiento y decisiones

Ambas versiones cumplieron los seis escenarios. VIBE fue más corto, pero dejó presentación, validación y cálculo en un archivo. SDD hizo explícita la separación y permitió probar la lógica sin widgets. Las métricas no prueban que un método sea mejor: la guía ya estaba en el contexto de trabajo y las pruebas manuales de VIBE no son equivalentes a las automatizadas de SDD.

En SDD, `AGENTS.md` contiene estructura y límites; `.specify/memory/constitution.md` fija SOLID; y `specs/001-divisor-cuenta/` conserva spec, plan, tareas y guía de ejecución. `clarify` no hizo preguntas: la especificación ya fijaba el cálculo de propina, los seis resultados, los mensajes y que el redondeo hacia arriba termina en 4.00. En VIBE no hubo conversación aparte para decidirlo; el contexto general ya daba esas reglas, por lo que no puedo atribuir honestamente cada decisión solo al agente.

## 2. Pruebas SDD llevadas a VIBE

La copia temporal de los tres archivos no compiló. El primer error fue:

```text
test/division_test.dart:2:8: Error: Error when reading 'lib/data/redondeo_exacto.dart': No such file or directory
```

El test importa además clases de `domain/` y `presentation/` que VIBE no tiene. Esto muestra una diferencia de arquitectura y testabilidad; por sí solo no demuestra un fallo funcional. Restauré `test/` al estado del commit VIBE después de la comparación.

Comprobé la interfaz de VIBE manualmente en Chrome:

| Escenario | Resultado |
|---|---|
| 100.00, 4, 10%, exacto | 27.50 |
| 90.00, 3, 0%, exacto | 30.00 |
| 50.00, 0 personas | “Debe haber al menos una persona”; sin resultado |
| Monto `abc` | “Monto inválido” |
| 10.00, 3, 0%, exacto | 3.33 |
| 10.00, 3, 0%, hacia arriba | 4.00 |

## 3. SOLID y evidencia

| Verificación | SDD | VIBE |
|---|---|---|
| `grep -rn "package:flutter" lib/domain/` | Sin salida: domain puro | `grep` informa que `lib/domain/` no existe; la app completa está en `lib/main.dart`, que importa Flutter |
| Instancias concretas de estrategias | Solo las dos líneas de `lib/main.dart` | Sin salida porque VIBE no define esas estrategias; no es evidencia de una composición SOLID |
| `is/as Redondeo` en el cálculo | Sin salida: no consulta tipos | El archivo de cálculo no existe |
| Formato o validación dentro de `CalcularDivision` | Sin salida | El archivo de cálculo no existe; en VIBE estas responsabilidades están juntas en `main.dart` |

La Constitution explica las diferencias: DIP exige domain Dart puro e inyección desde la composición; OCP y LSP exigen depender de `EstrategiaRedondeo` sin preguntar su tipo; ISP limita esa interfaz a un método; SRP separa cálculo, validación, formato y dibujo. En VIBE, la falta de capas hace que esas comprobaciones no apliquen o fallen por archivos ausentes, no por un error funcional observado.

## 4. Clarify

No surgieron preguntas relevantes. El documento especificaba monto, personas, porcentaje, modo de redondeo, salidas y errores para cada caso. Eso evitó decisiones abiertas que cambiaran la implementación o las pruebas. En VIBE, las seis reglas también estaban presentes en el contexto general de la tarea; por tanto, no sería exacto decir que el agente las infirió por completo desde una frase mínima.

## 5. Diferencias de código

`git diff vibe sdd --stat` dio **53 archivos cambiados, 5869 inserciones y 104 eliminaciones**. La mayoría de las inserciones son los skills, scripts y plantillas que Spec Kit instaló, además de los artefactos pedidos. En el código Dart, VIBE tiene 1 archivo y 119 líneas; SDD tiene 11 archivos y 253 líneas. No se añadió una pantalla, persistencia ni conexión. SDD sí agrega una validación y mensaje para propina inválida que no aparece entre los seis escenarios.

Para retomar SDD, un compañero puede leer `AGENTS.md`, `spec.md` y `plan.md`; en VIBE tendría que deducir las responsabilidades desde `main.dart`. Para agregar redondeo a múltiplo de cinco, SDD indica crear otra estrategia en `data/`; el caso de uso `CalcularDivision` no necesita cambiar. En VIBE, cálculo y UI están mezclados y no hay punto de extensión equivalente.

## 6. Otra herramienta y cuándo usar VIBE

OpenSpec organiza un cambio como propuesta, especificaciones por capacidad, diseño, tareas y aplicación. Spec Kit en esta práctica usa Constitution y el flujo specify, clarify, plan, tasks, analyze, implement y converge. Preferiría OpenSpec para cambios incrementales en un sistema existente cuando importa guardar la motivación y las diferencias de requisitos por capacidad; su carpeta de cambios y las especificaciones delta ayudan a revisar qué comportamiento cambia. Fuentes oficiales consultadas: [flujo spec-driven de OpenSpec](https://openspec.dev/docs/schemas/spec-driven) y [repositorio de GitHub Spec Kit](https://github.com/github/spec-kit).

VIBE tiene sentido para un prototipo local y desechable —por ejemplo, probar en una tarde si un formulario de una pantalla resulta cómodo— cuando el objetivo es recibir retroalimentación rápida y no habrá mantenimiento ni colaboración inmediata.

## Verificación final

- [x] Ramas `main`, `vibe` y `sdd`; mismo commit inicial `67cd8e6`.
- [x] `AGENTS.md`, `.specify/`, Constitution, spec, plan y tareas en SDD.
- [x] `test/casos_de_prueba.dart`, `test/division_test.dart` y `test/pantalla_test.dart` en SDD.
- [x] SDD: `flutter test` — 10 pruebas aprobadas.
- [x] SDD: `flutter analyze` — “No issues found!”.
- [x] SDD: `flutter build apk --debug` — compiló; la primera compilación limpia tardó 189.4 s y la verificación final, tras limpiar dependencias de plantilla, recompiló en 3.3 s.
- [x] Las cuatro búsquedas SOLID de SDD dieron los resultados descritos arriba.
- [x] Pruebas temporales restauradas en VIBE; los seis flujos se comprobaron manualmente.
- [x] Las 13 tareas de `specs/001-divisor-cuenta/tasks.md` quedaron marcadas.
- [x] Publicar en GitHub las ramas `main`, `vibe` y `sdd` sin forzar ni reescribir historia; confirmé las tres refs remotas.

## Adaptación de Spec Kit

La versión instalada es 1.0.13 y configuró la integración de Codex en modo skills. En este entorno, `specify init` y sus scripts son comandos de terminal; Constitution, specify, clarify, plan, tasks, analyze, implement y converge son instrucciones/skills del agente, no subcomandos del CLI. Apliqué esas instrucciones y guardé sus artefactos en el proyecto. La primera inicialización sin `--force` se detuvo porque el proyecto Flutter ya tenía archivos; la inicialización con `--force` los combinó y terminó correctamente. El paso de clarify concluyó con cero preguntas relevantes. Tras implementar, la revisión de convergencia no encontró tareas pendientes ni diferencias no resueltas frente a spec, plan y Constitution.
