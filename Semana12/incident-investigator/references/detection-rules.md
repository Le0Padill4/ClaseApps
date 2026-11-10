# Reglas de detección

Ordena por `timestamp`, mantén el número de fila original y usa ventanas de hasta cinco minutos, incluidos ambos extremos. Compara `event` y `result` exactamente. Si el archivo contiene filas idénticas y no hay identificador que permita distinguir eventos repetidos de duplicados de registro, menciónalo; no supongas cuál es el caso.

- **Fuerza bruta probable:** seis o más eventos `login` / `failed`, misma IP y usuario, en una ventana de ≤ 5 minutos. Registra por separado cualquier `login` / `success` posterior de la misma IP y usuario dentro de los siguientes cinco minutos, indicando las filas.
- **Password spraying probable:** eventos `login` / `failed` de una misma IP contra al menos cinco usuarios distintos en ≤ 5 minutos.
- **Token potencialmente expuesto:** `detail` contiene `token=`. Muestra solo `token=[REDACTED]`, incluso en trazas y salidas intermedias.
- **Cambio de privilegio sin aprobación según el registro:** `role_change` / `success` con `approved=false` en `detail`; no implica que se conozca la intención ni el responsable.
- **Controles:** tres fallos aislados no alcanzan el umbral de fuerza bruta. Un `healthcheck` no es un `login` / `failed`, aunque se repita.

Las severidades son orientativas. Los resultados son alertas justificadas por registros, no conclusiones forenses ni pruebas de culpabilidad.
