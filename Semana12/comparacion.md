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

El aporte más claro fue hacer explícitos los umbrales y la limitación de los duplicados. Sin el skill, el agente también encontró las señales principales. Se trata de una corrida por condición, no de una prueba estadística.

## Tokens y equivalencia de costo

El modelo configurado para estas sesiones fue `gpt-6.1-sol`, con el esfuerzo de razonamiento `xhigh`. Las trazas registraron estos valores para las dos sesiones independientes de la comparación:

| Sesión | Tokens de entrada | Entrada en caché | Entrada sin caché | Tokens de salida | Total de tokens | Costo teórico |
|---|---:|---:|---:|---:|---:|---:|
| Sin skill | 83 193 | 76 032 | 7 161 | 1 914 | 85 107 | $0,0411 |
| Con skill | 105 779 | 95 232 | 10 547 | 2 370 | 108 149 | $0,0543 |
| **Total** | **188 972** | **171 264** | **17 708** | **4 284** | **193 256** | **$0,0954** |

El cálculo usa los precios estándar oficiales por millón de tokens para `gpt-6.1-sol`: $2,00 por entrada sin caché, $0,10 por entrada en caché y $10,00 por salida. No hubo tokens de escritura de caché registrados. La fórmula fue: `(entrada sin caché × 2 + entrada en caché × 0,10 + salida × 10) / 1 000 000`.

Los tokens de razonamiento están incluidos dentro de los tokens de salida; las trazas registraron 67 en la sesión sin skill y 23 en la sesión con skill. El valor es una equivalencia teórica según el precio de API, no un cobro real de Codex ni un recibo de la cuenta. Los precios pueden cambiar; se consultaron en la [página oficial de precios de OpenAI](https://developers.openai.com/api/docs/pricing).
