# Llavero — guion de demo

## El problema

En Bolivia, entrar a un anticrético normalmente exige inmovilizar entre USD 10.000 y 40.000 en efectivo. Para un pequeño ahorrista, eso significa quedar fuera del mercado o concentrar casi todo su capital en un solo inmueble, con poca trazabilidad y el riesgo de que el contrato no esté inscrito correctamente.

## La solución

Llavero permite que varias personas cofinancien un anticrético en Bolivia desde 100 USDC en Stellar, cobren renta mensual mientras el inmueble está alquilado y recuperen su capital al final del plazo. La SRL anticresista concentra la relación legal con el inmueble y el capital sólo se libera al dueño después de validar la inscripción del anticrético en Derechos Reales; los inversionistas pueden verificar cada movimiento on-chain.

## Demo de 3 minutos

**Preparación fuera de cámara:** Freighter debe estar en Stellar Testnet y usar la wallet demo autorizada como inversionista, admin y owner. Restablecé el dataset para que `Casa en Sopocachi` empiece `En fondeo`, sin la distribución del ensayo anterior. Dejá una segunda pestaña abierta en [anticretico.vercel.app/propiedades](https://anticretico.vercel.app/propiedades) para demostrar Realtime. Las seis fichas son datos de demostración cargados en Supabase; no afirmar que son inmuebles verificados para inversión real.

- **0:00–0:20 — Catálogo.** Abrí Llavero en [anticretico.vercel.app/propiedades](https://anticretico.vercel.app/propiedades). Mostrá el encabezado `Llavero: invierte en anticréticos bolivianos desde 100 USDC`, las seis propiedades y el ciclo completo en las etiquetas: `En fondeo`, `En trámite`, `Buscando inquilino`, `Alquilado` y `Finalizado`. Resultado esperado: seis tarjetas, cada una con estado, meta, avance de fondeo, alquiler mensual variable y enlace `Ver detalles`.
- **0:20–0:50 — Inversión con firma real.** En la tarjeta `Sopocachi, La Paz` de `Av. 20 de Octubre #1234`, hacé clic en `Ver detalles`; la URL debe ser [anticretico.vercel.app/propiedades/casa-sopocachi-la-paz](https://anticretico.vercel.app/propiedades/casa-sopocachi-la-paz). En `Monto`, dejá `100`, hacé clic en `Continuar`, autorizá Freighter, verificá `Stellar Testnet`, hacé clic en `Firmar` y aprobá la transacción en Freighter. Resultado esperado: `Inversión confirmada`, posición registrada y chip con el hash real.
- **0:50–1:00 — Explorer.** Hacé clic en el chip del hash. Resultado esperado: una nueva pestaña de Stellar Expert Testnet con la transacción exitosa, origen, destino, monto y operaciones; volvé a la app.
- **1:00–1:35 — Derechos Reales y liberación.** Abrí [anticretico.vercel.app/admin](https://anticretico.vercel.app/admin), hacé clic en `Conectar wallet` y autorizá la misma wallet. En `Validaciones pendientes`, ubicá Sopocachi y hacé clic en `Validar DR y liberar`; escribí `LIBERAR` y hacé clic en `Liberar`. Resultado esperado: `Escrow liberado on-chain`, hash con enlace al explorer y Sopocachi pasa a `Buscando inquilino`. Esta acción valida el hito demo de DR y la cuenta de escrow firma la liberación en el servidor; no hay una segunda firma Freighter.
- **1:35–1:45 — Cambio en vivo.** Sin recargar, cambiá a la segunda pestaña del catálogo. Resultado esperado: la etiqueta de Sopocachi cambia de `En fondeo` a `Buscando inquilino` por la suscripción Supabase Realtime. Volvé a `/admin`.
- **1:45–2:05 — Renta mensual.** Hacé clic en la pestaña `Distribuciones`, luego en `Distribuir vía Pollar` para Sopocachi; escribí `DISTRIBUIR` y hacé clic otra vez en `Distribuir vía Pollar`. Resultado esperado: sobre 320 USDC de alquiler se muestran 48 USDC de comisión y 272 USDC netos; aparece `Distribuidos 272 USDC a 1 holders`, un hash real y el estado pasa a `Alquilado`. La transacción es un pago batch Stellar equivalente al flujo Pollar del piloto.
- **2:05–2:25 — Resultado para el inversionista.** Abrí [anticretico.vercel.app/dashboard](https://anticretico.vercel.app/dashboard). Resultado esperado: la misma wallet muestra `100 USDC` invertidos, una posición en Sopocachi y `272 USDC` en distribuciones recibidas, marcadas como variables; ambos movimientos tienen enlace al explorer.
- **2:25–2:45 — Decisión del owner.** Abrí [anticretico.vercel.app/owner](https://anticretico.vercel.app/owner). En Sopocachi, mové el slider a `70%` para retirar y `30%` para DeFi; señalá la advertencia de que Blend es un stub de testnet. Hacé clic en `Firmar y ejecutar` y aprobá en Freighter. Resultado esperado: una transacción compuesta, `70 USDC retirados · 30 USDC en DeFi` y enlace al explorer.
- **2:45–3:00 — Rollover.** Volvé a [anticretico.vercel.app/admin](https://anticretico.vercel.app/admin) y hacé clic en `Rollover`. Seleccioná como origen el Sopocachi `Finalizado` de Av. Ecuador y como destino Equipetrol `En fondeo`; mostrá la advertencia, el campo de confirmación `ROLLOVER` y el botón `Ejecutar migración`, sin ejecutarlo durante esta demo. Resultado esperado: queda claro el flujo para migrar posiciones a una nueva serie; hoy la migración demo se registra en Supabase y se ancla con una transacción Stellar.

## Los números

| Métrica | Número honesto |
|---|---:|
| Inversión mínima | 100 USDC |
| Comisión de plataforma | 15% del alquiler mensual, antes de distribuir el neto |
| Mercado boliviano | No existe un censo público confiable del anticrético; como orden de magnitud, cada 1.000 contratos activos representa USD 10–40 millones inmovilizados. El número nacional aún debe validarse. |

## Enviado vs. roadmap

| Enviado en el hackathon | Roadmap para un piloto real |
|---|---|
| Los siete recorridos del MVP funcionan de punta a punta en Stellar testnet: catálogo con cinco estados, inversión y firma Freighter, validación y liberación, distribución batch, explorer, asignación 70/30 del owner, rollover, dashboard y actualización Realtime. Los movimientos on-chain son reales, pero el piloto usa XLM rotulado como USDC, una cuenta de escrow en lugar del contrato Trustless Work, distribución batch equivalente a Pollar, cuenta stub para Blend y bookkeeping de rollover en Supabase. | Contrato de escrow de Trustless Work; integración real con Blend; activo USDC real; contrato Soroban para rollover; proveedor de KYC. Antes de mainnet también corresponde constituir y probar la SRL, cerrar el marco regulatorio y rotar todos los secretos. |

## Credibilidad técnica

- Transacciones reales y exitosas en Stellar Testnet: [inversión `17c35e332ddfb683f5a965b2cd25d9d7d7de8c0f608c431230a984981a625b3d`](https://stellar.expert/explorer/testnet/tx/17c35e332ddfb683f5a965b2cd25d9d7d7de8c0f608c431230a984981a625b3d), [liberación `7f09124bdf277d10b680ea727827b40a039356be0de3cba59b4b021af469730f`](https://stellar.expert/explorer/testnet/tx/7f09124bdf277d10b680ea727827b40a039356be0de3cba59b4b021af469730f) y [distribución `88c8777511ec980371e9e1bc9541845dd09b1d8cfecaaaa9754ceaef98c3ffc6`](https://stellar.expert/explorer/testnet/tx/88c8777511ec980371e9e1bc9541845dd09b1d8cfecaaaa9754ceaef98c3ffc6).
- Supabase Realtime escucha cambios de `properties` y actualiza estado y fondeo del catálogo sin recargar la página.
- Freighter firma las transacciones del inversionista y del owner, bloquea redes distintas de Testnet y conserva la misma wallet para dashboard y control de acceso admin; las acciones operativas de admin usan cuentas servidoras autorizadas.

## Equipo + autoría

Detalle completo en [TEAM.md](TEAM.md).

- **Angel Flores — Tech Lead:** arquitectura, código del MVP (app Next.js, integración Stellar/Freighter, Supabase Realtime), demo técnica y despliegue en testnet.
- **Cecilia Flores — Producto, Legal y Negocio:** análisis legal boliviano (anticresis en el Código Civil, Ley 393, DS 5384, RD 082/2024 del BCB), modelo de negocio, investigación y sizing de mercado, entrevistas de validación y narrativa del pitch deck.

## Validación

El marco legal trabajado, los scripts de entrevista con ahorristas y propietarios, los hallazgos, el sizing bottom-up del nicho en Santa Cruz y la economía del piloto están en [VALIDATION.md](VALIDATION.md).
