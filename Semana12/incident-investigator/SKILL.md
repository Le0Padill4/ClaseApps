---
name: incident-investigator
description: Investiga posibles incidentes en logs sintéticos CSV de autenticación y seguridad, incluidos accesos sospechosos, cambios de permisos y secretos expuestos. Úsalo al solicitar una investigación de seguridad con evidencia; no lo uses para conteos o visualizaciones descriptivas sin investigación.
---

# Investigador de incidentes

Trabaja exclusivamente con los registros sintéticos proporcionados. No consultes servicios externos ni direcciones IP; no modifiques el CSV. No imprimas tokens ni secretos completos, incluidos resultados intermedios y comandos: reemplaza el valor por `[REDACTED]` antes de mostrarlo.

1. Inspecciona el encabezado, formato y tipos de `timestamp`, `ip`, `user`, `event`, `result` y `detail`. Conserva el número de fila original, contando el encabezado como fila 1.
2. Antes de investigar, lee [las reglas de detección](references/detection-rules.md). Ordena cronológicamente sin perder los números originales.
3. Aplica las reglas a los eventos exactos y ventanas indicadas. Identifica duplicados solo si hay evidencia inequívoca; de otro modo señala la limitación sin descartarlos arbitrariamente.
4. Para cada alerta registra sus filas y los datos relevantes. Separa una alerta de un hecho confirmado; no atribuyas culpabilidad ni inventes eventos. Describe incertidumbre y limitaciones.
5. Devuelve una tabla con alerta, severidad orientativa, regla, timestamp, IP, usuario, filas/evidencia y limitaciones. Explica también casos que no alcanzaron el umbral y actividad normal pertinente.

Las IP reservadas para documentación no representan infraestructura real. Un conteo o una visualización sin investigación no necesitan este skill.
