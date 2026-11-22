# E2 — Invest (ANT-INVEST + ANT-EXPLORER)

Epic: wallet connect + USDC deposit into Trustless Work escrow.

## Screens

### E2-01-Wallet-connect-modal

Not a route, modal on any screen that needs a wallet.

Component: `WalletConnectModal`. See its README for anatomy.

Acceptance:
- Modal opens from any `Conectar wallet` button.
- Freighter row is marked "Recomendado" and sits first.
- If the wallet is on the wrong network, a second modal "Cambia a Testnet" blocks.
- On success, the modal returns `publicKey` to the caller and closes.

### E2-02-Invest-flow

Opens from `E1-03-Property-detail` → `Invertir` button.

Four steps, all inside a single centred card (420 wide, `shadow.modal`, `bg-elevated`, `radius.lg`). Step 1 is in-page on property detail; steps 2–4 are a stacked modal.

#### Step 1 — Amount (in-page, replaces the Invertir button on property detail)

```
┌─ Invertir ──────────────────────────────┐
│                                         │
│ Monto                                   │
│ [Input variant="number-usdc"] [USDC]    │
│ Mínimo 100 USDC                         │
│                                         │
│ Tu posición será una fracción de la     │
│ anticrético, con rendimiento variable.  │
│                                         │
│ [RiskDisclosure invest-variable-yield]  │
│ [RiskDisclosure invest-testnet]         │
│                                         │
│ [Button primary "Continuar"]            │
└─────────────────────────────────────────┘
```

#### Step 2 — Confirm (modal)

```
┌─ Confirmar inversión ──────────────────┐
│                                        │
│ Propiedad    Casa en Sopocachi         │
│ Monto        2.000 USDC                │
│ % del anticrético    16.6%             │
│ Wallet       GABC…X1Y2                 │
│ Red          Stellar Testnet           │
│ Escrow       Trustless Work            │
│                                        │
│ [RiskDisclosure invest-variable-yield] │
│                                        │
│ [Secondary Cancelar] [Primary Firmar]  │
└────────────────────────────────────────┘
```

Clicking `Firmar` triggers the Freighter signature prompt.

#### Step 3 — Signing (modal, loading)

Same modal, buttons replaced by a centred spinner and copy: `Firmando con Freighter…`, then `Enviando a la red Stellar…`. No cancel option while in-flight.

#### Step 4 — Receipt (modal, success)

```
┌─ Inversión confirmada ✓ ───────────────┐
│                                        │
│ [state-success check icon, 48]         │
│                                        │
│ 2.000 USDC enviados al escrow          │
│                                        │
│ Tx [ExplorerLink tx]                   │
│ Escrow [ExplorerLink account]          │
│                                        │
│ Verás tu posición en "Mi dashboard"    │
│ en cuanto el bloque se confirme.       │
│                                        │
│ [Primary "Ver mi dashboard"]           │
│ [Ghost "Volver a la propiedad"]        │
└────────────────────────────────────────┘
```

#### Error state (modal, danger)

If the tx fails: title becomes `Inversión no completada`, body shows the error code + a `state-danger` block. Primary button is `Reintentar`; secondary is `Cancelar`.

Acceptance:
- All amounts render with `.` thousand separator in `es-BO`.
- The `ExplorerLink` must be the real testnet tx hash — not a placeholder.
- Step 4 `Ver mi dashboard` routes to `E3-01-Investor-dashboard`.
- The flow is reversible up to step 2 (Cancelar). After `Firmar`, no cancel.
