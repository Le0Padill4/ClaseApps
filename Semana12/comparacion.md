# Comparación: sin y con `incident-investigator`

Se hicieron dos ejecuciones independientes de Codex, sin conectores, con el mismo CSV y la misma solicitud: «Investiga los logs sintéticos, identifica incidentes justificables y distingue señales de seguridad de actividad normal. Devuelve evidencia concreta». En ambas se pidió no usar la red, modificar el archivo ni mostrar tokens. La primera comenzó fuera del repositorio y no leyó el skill ni sus reglas; la segunda comenzó en el repositorio y leyó ambos archivos. Las dos terminaron; las trazas están en `evidencias/`.

| Dimensión | Sin `incident-investigator` | Con `incident-investigator` | Evidencia / comentario |
|---|---|---|---|
| ¿Procedimiento reproducible? | Separó hallazgos y actividad normal, sin indicar umbrales concretos. | Indicó las reglas y ventanas de hasta cinco minutos. | La segunda respuesta cita los criterios de las alertas. |
| ¿Citó filas concretas? | Sí. | Sí. | Ambas citaron la fila 33 y las filas 67, 68, 70, 71, 73 y 74. |
| Alertas sustentadas | Token, cambio de rol y dos patrones de autenticación. | Las mismas cuatro alertas. | Coincidieron en las señales principales. |
| Falsos positivos detectados o evitados | Separó los tres fallos de María y el monitoreo. | También los separó y explicó por qué no cumplen las reglas. | Filas 38, 39, 41 y 78, 80–84. |
| ¿Ocultó posibles tokens? | Sí. | Sí. | Ambas respuestas redactaron el valor. |
| ¿Reconoció incertidumbre? | Sí sobre identidad, compromiso y uso del token, pero no mencionó los pares de filas idénticas. | Sí, señaló los pares idénticos y explicó que podrían dejar solo cinco eventos distintos. | Pares 19–20, 22–23 y 25–26. |
| ¿Qué hizo gracias al skill? | No cargó `incident-investigator`. | Leyó el procedimiento y la referencia, y aplicó sus criterios y formato. | La traza muestra las lecturas; no es posible atribuir con certeza cada frase solo al skill. |

El aporte más claro fue hacer explícitos los umbrales y la limitación de los duplicados. Sin el skill, el agente también encontró las señales principales. Se trata de una corrida por condición, no de una prueba estadística. Tiempo y tokens comparables: **no disponible**.
