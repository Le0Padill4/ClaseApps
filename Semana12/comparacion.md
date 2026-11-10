# Comparación: sin y con `incident-investigator`

Se hicieron dos ejecuciones independientes de Codex con el mismo CSV y la misma solicitud: «Investiga los logs sintéticos, identifica incidentes justificables y distingue señales de seguridad de actividad normal. Devuelve evidencia concreta». Se añadieron en ambas las mismas indicaciones para no usar la red, modificar el archivo ni mostrar tokens. La primera comenzó fuera del repositorio y no leyó el skill ni sus reglas; sí usó el skill general `tareas-academicas`. La segunda comenzó en el repositorio y leyó `incident-investigator/SKILL.md` y su referencia. Ambas terminaron. Las trazas están en `evidencias/`.

| Dimensión | Sin `incident-investigator` | Con `incident-investigator` | Evidencia / comentario |
|---|---|---|---|
| ¿Procedimiento reproducible? | Separó hallazgos y actividad normal, pero no indicó umbrales concretos. | Aplicó las reglas y ventanas de hasta cinco minutos. | La segunda respuesta cita los criterios de cada alerta. |
| ¿Citó filas concretas? | Sí. | Sí. | Ambas citaron, por ejemplo, la fila 33 y las filas 67, 68, 70, 71, 73 y 74. |
| Alertas sustentadas | Token, cambio de rol y dos patrones de autenticación. | Las mismas cuatro alertas. | Los resultados principales coincidieron. |
| Falsos positivos detectados o evitados | Separó los tres fallos de María y el monitoreo. | También los separó y explicó por qué no cumplen las reglas. | En ambos informes aparecen las filas 38, 39, 41 y 78, 80–84. |
| ¿Ocultó posibles tokens? | Sí. | Sí. | Ambas respuestas redactaron el valor. |
| ¿Reconoció incertidumbre? | Sí, señaló los registros idénticos y que no prueban ocho intentos independientes. | Sí, y aclaró que con cinco registros distintos no se cumpliría el umbral de seis. | Pares 19–20, 22–23 y 25–26. |
| ¿Qué hizo gracias al skill? | No cargó `incident-investigator`. | Leyó el procedimiento y la referencia, y usó sus criterios y formato. | La traza muestra las lecturas; no es posible atribuir con certeza cada frase solo al skill. |

El aporte más claro fue hacer explícitos los umbrales, la ventana y las limitaciones. Sin el skill, el agente también encontró las señales principales, así que no sería correcto decir que solo el skill permitió encontrarlas. Se trata de una corrida por condición, no de una prueba estadística. Tiempo y tokens comparables: **no disponible**.
