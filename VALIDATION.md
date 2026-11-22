# Llavero — validación

Documento de trabajo para la presentación presencial del 27 de noviembre en Santa Cruz. Responsable: Cecilia Flores (ver [TEAM.md](TEAM.md)). Todo lo marcado como **[PENDIENTE]** se completa con datos reales antes del 27; lo marcado como **[VERIFICAR]** se contrasta con el texto oficial o con el asesor legal antes de citarlo en el pitch.

## Marco legal boliviano (ya trabajado)

> Resumen de trabajo del equipo, no es una opinión legal. Antes de operar con dinero real se valida con un asesor legal boliviano.

### Código Civil, arts. 1429–1435 — contrato de anticresis
- La anticresis es un contrato por el cual se entrega un inmueble al acreedor (anticresista) como garantía de un crédito, con derecho a ocuparlo o percibir sus frutos mientras dure el contrato.
- Al vencimiento, el propietario devuelve el capital recibido y el anticresista restituye el inmueble.
- Para que el contrato sea oponible frente a terceros debe constar por escrito e inscribirse en Derechos Reales; por eso Llavero sólo libera el capital al dueño después de validar esa inscripción.
- El anticresista asume obligaciones de conservación del inmueble mientras lo tiene en su poder.
- **[VERIFICAR]** Citar artículo por artículo con el texto vigente antes de usar números de artículo concretos en el deck.

### Ley 393 de Servicios Financieros — por qué el piloto cerrado no configura captación pública
- La Ley 393 reserva a entidades autorizadas por ASFI la captación de recursos del público y la intermediación financiera.
- Argumento del equipo: el piloto cerrado **no** capta recursos del público porque (1) no hay oferta pública ni publicidad, (2) participan sólo inversionistas de la red directa del equipo, con un número acotado de participantes, (3) cada aporte está ligado a un inmueble y un contrato de anticresis concreto e inscrito, no a un fondo general, y (4) Llavero no presta ni reinvierte los aportes por su cuenta.
- **[VERIFICAR]** Confirmar con el asesor los umbrales (número de inversionistas, montos, forma de convocatoria) a partir de los cuales ASFI podría considerarlo captación.

### DS 5384 — sandbox regulatorio de ASFI
- Habilita un entorno de pruebas controlado para modelos de negocio financieros innovadores, con supervisión de ASFI y límites de operación.
- Criterios de ingreso a documentar: **[VERIFICAR]** contra el texto del decreto y la reglamentación de ASFI (innovación demostrable, beneficio para el usuario, plan de pruebas acotado en tiempo/usuarios/montos, mitigación de riesgos y protección al consumidor, plan de salida).
- Rol en la estrategia: camino para escalar después del piloto cerrado, cuando se abra a inversionistas fuera de la red del equipo.

### RD 082/2024 del BCB — USDC como medio de pago
- En 2024 el BCB levantó la prohibición anterior sobre activos virtuales y permitió su uso a través de canales e instrumentos electrónicos de pago autorizados.
- Precisión para el pitch: esto permite operar con activos virtuales como USDC por canales autorizados; **no** los convierte en moneda de curso legal. Evitar decir "USDC es moneda legal en Bolivia".
- **[VERIFICAR]** Qué canales autorizados aplican a la entrada y salida de USDC de los inversionistas del piloto.

### Pregunta abierta para el asesor
- ¿Puede la SRL anticresista subarrendar (alquilar a un tercero) el inmueble que recibe en anticrético, y bajo qué condiciones? ¿Debe constar expresamente en el contrato? ¿Qué implicaciones tributarias tiene el alquiler cobrado por la SRL?

## Entrevistas planificadas (22–27 noviembre)

**Target:** 10 ahorristas de Santa Cruz con DPF + 5 propietarios o corredores.

### Script de entrevista (ahorrista)
1. ¿En qué guardás tus ahorros hoy? (DPF, dólares físicos, USDT, etc.)
2. ¿Cuánto podrías mover a un instrumento que rente 4–8% USD al año, con capital protegido por lien inmobiliario, con ticket mínimo 100 USDC?
3. ¿A qué plazo te comprometerías? (1, 2, 3 años)
4. ¿Qué te impediría hacerlo? (confianza, custodia, liquidez, otra)
5. ¿Tenés USDC o estarías dispuesto a comprarlo?

### Script de entrevista (propietario/corredor)
1. ¿Cuántos anticréticos manejás al mes?
2. ¿Promedio de ticket en USD?
3. ¿Qué parte del anticrético toca cerrarse rápido y qué parte queda a la espera?
4. ¿Firmarías una carta de intención para poner 1 inmueble en Llavero en el piloto cerrado (sin publicidad, inversores de nuestra red)?
5. ¿Qué comisión te dejaría operar?

### Hallazgos

| Fecha | Perfil (sin nombre) | Rol | Monto dispuesto | Plazo | Barreras | Carta de intención |
|---|---|---|---|---|---|---|
| | | | | | | |

**Resumen (completar al cerrar las entrevistas):** [PENDIENTE] cuántos ahorristas moverían dinero y cuánto en promedio, barrera más citada, cuántas cartas de intención firmadas.

## Sizing del nicho (bottom-up)

Reemplaza el dato agregado "Bs 112.580 MM total DPF", que mide todo el sistema y no el mercado alcanzable.

Estimación por capas:
- Clase media en Santa Cruz: ~[PENDIENTE: X] personas con ingresos declarados mayores a [PENDIENTE: Y] Bs/mes (fuente: INE).
- De ellas, ~[PENDIENTE: Z]% tiene DPF o ahorros en USD (fuente: ASFI, datos por departamento).
- De ese pool, sólo una fracción adoptaría USDC en 1–2 años: [PENDIENTE: %, con supuesto explícito y, si es posible, respaldado por las entrevistas].
- Ticket promedio esperado por inversionista: [PENDIENTE: USD, a partir de la pregunta 2 de las entrevistas].
- **Resultado:** nicho alcanzable en Santa Cruz = USD [PENDIENTE: X]–[PENDIENTE: Y] MM en 3 años.

## Economía del piloto

Pregunta: con 15% de comisión sobre el alquiler, ¿cuántos inmuebles hacen falta para cubrir los costos legales y notariales fijos del primer año?

- Gasto fijo estimado por operación (asesor legal + inscripción en Derechos Reales + notaría): USD [PENDIENTE: X].
- Comisión promedio por inmueble: 15% × 300 USD/mes × 12 = **USD 540 anuales**.
- Break-even operativo: N = X ÷ 540 → **[PENDIENTE: N] inmuebles**.
- Nota: si parte del gasto es fijo anual (por ejemplo, el asesor legal) y no por operación, separarlo: N = gasto fijo anual ÷ (540 − gasto variable por inmueble).
