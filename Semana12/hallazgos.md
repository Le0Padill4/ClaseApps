# Hallazgos

El archivo tiene 93 registros. Se conservaron los números de fila originales, incluido el encabezado como fila 1, y se ordenaron las horas para comprobar las ventanas. Las IP son de documentación. Las severidades son orientativas; las alertas no demuestran un ataque ni identifican responsables.

| Alerta | Severidad orientativa | Regla | Hora (-05:00) | IP | Usuario | Filas y evidencia | Limitaciones |
|---|---|---|---|---|---|---|---|
| Posible fuerza bruta | Alta | ≥ 6 `login/failed` de la misma IP y usuario en ≤ 5 minutos | 01:14–01:18 | 198.51.100.77 | admin | 17, 19, 20, 22, 23, 25, 26 y 27: ocho filas de fallos. | Las parejas 19–20, 22–23 y 25–26 son idénticas. No se puede saber si son eventos independientes o duplicados; si fueran duplicados de registro quedarían cinco eventos distintos y no se alcanzaría el umbral. |
| Acceso exitoso posterior | Alta | `login/success` después de la ventana anterior | 01:19 | 198.51.100.77 | admin | Fila 28, un minuto después del último fallo. | El éxito es un hecho registrado, no prueba por sí solo un acceso indebido. La alerta anterior depende de la limitación de duplicados. |
| Posible password spraying | Alta | Fallos de la misma IP contra ≥ 5 usuarios distintos en ≤ 5 minutos | 02:01–02:03 | 203.0.113.89 | ana, carlos, luisa, diego, maria y sofia | Filas 67, 68, 70, 71, 73 y 74: seis usuarios distintos en dos minutos. | La secuencia es sospechosa, pero no permite atribuir intención. |
| Token potencialmente expuesto | Alta | `detail` contiene `token=` | 01:27 | 192.0.2.44 | api_service | Fila 33: `token=[REDACTED]`. | El archivo es sintético; no se comprueba si el token funciona. |
| Cambio de rol sin aprobación registrada | Alta | `role_change/success` con `approved=false` | 01:50 | 203.0.113.42 | guest | Fila 59: cambio de `user` a `admin` y `approved=false`. | El registro indica que no había aprobación; no prueba quién lo causó. La fila 57 muestra un acceso denegado anterior. |

**Controles:** Las filas 38, 39 y 41 muestran tres fallos de `maria` desde 192.0.2.25 en dos minutos; no llegan a seis, así que no cumplen la regla de fuerza bruta. La fila 42 registra un acceso exitoso posterior, que no cambia ese umbral. Las filas 78, 80–84 son `healthcheck/success`, no fallos de inicio de sesión.

**Comprobación:** se contrastaron las filas 67, 68, 70, 71, 73 y 74 con el CSV original: corresponden a la misma IP y a seis usuarios entre 02:01 y 02:03. Falta que el estudiante haga su propia verificación, como pide el enunciado.

El CSV original se mantiene intacto en la copia local. No se incluye en este PR público porque la fila 33 contiene el valor completo de un token y el enunciado también prohíbe incluir tokens completos en el PR. SHA-256 del original y la copia local: `7d8219e9f8c9dd995be0c2dc038f4f7e67f0f12446b4fdc07fadf508befb5da8`.
