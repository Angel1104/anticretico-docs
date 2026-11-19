# E5 — Owner panel + Rollover (ANT-OWNER + ANT-ROLLOVER)

Epic: owner chooses Retirar / DeFi / Mixto with risk disclosure; at Finalizado, rollover to another anticrético.

## Screens

### E5-01-Owner-panel

`/owner` — gated to owner role on properties owned by the logged-in user. Shows one block per property.

```
┌──────────────────────────────────────────────────────┐
│ TESTNET banner                                       │
├──────────────────────────────────────────────────────┤
│ Nav (owner links: Mis propiedades · Panel owner)     │
├──────────────────────────────────────────────────────┤
│                                                      │
│  Panel owner                                         │
│                                                      │
│  Casa en Sopocachi, La Paz                           │
│  [StatePill Buscando inquilino]                      │
│                                                      │
│  Recibiste 12.000 USDC del anticrético.              │
│  Elige qué hacer con el capital:                     │
│                                                      │
│  ┌─── Retirar ────────┐┌─── DeFi ────────┐┌─ Mixto ─┐│
│  │ [icon wallet]      ││ [icon stack]    ││[icon %] ││
│  │                    ││                 ││         ││
│  │ Envía el USDC a tu ││ Deposita en     ││ Divide  ││
│  │ wallet. Pierdes    ││ Blend (testnet).││ entre   ││
│  │ exposición a la    ││ Puede generar   ││ los dos ││
│  │ renta.             ││ yield variable  ││ con un  ││
│  │                    ││ extra.          ││ slider. ││
│  │                    ││                 ││         ││
│  │ [Risk withdraw-cash]││[Risk defi-prot.]││[Risk mix]│
│  │                    ││                 ││         ││
│  │ [Button secondary] ││ [Button primary]││[Button] ││
│  │ Retirar 12.000 USDC││ Depositar       ││Configurar│
│  └────────────────────┘└─────────────────┘└─────────┘│
│                                                      │
│  Historial on-chain                                  │
│  • Escrow liberado · [Explorer tx]                   │
│  • Depósito Blend · [Explorer tx] · si corresponde   │
└──────────────────────────────────────────────────────┘
```

Each option opens its own confirmation modal:
- `Retirar`: confirmWord = `RETIRAR`. Sends all USDC to the owner wallet.
- `DeFi`: confirmWord = `DEPOSITAR`. Shows protocol (Blend on testnet, locked — see `decisions/001-design-trade-offs.md`) + expected pool composition + confirm.
- `Mixto`: opens a slider screen first (see below).

#### Mixto slider

Modal, 480 wide. Slider from 0–100 representing the % going to DeFi.

```
┌─ Dividir capital ──────────────────────┐
│                                        │
│ Total          12.000 USDC             │
│                                        │
│ [slider ──────●────────]               │
│                                        │
│ Retirar  40%  4.800 USDC               │
│ DeFi     60%  7.200 USDC               │
│                                        │
│ [RiskDisclosure mixed-split]           │
│ [RiskDisclosure defi-protocol-risk]    │
│                                        │
│ [Secondary Cancelar] [Primary Firmar]  │
└────────────────────────────────────────┘
```

Acceptance:
- Each option shows its required `RiskDisclosure`.
- The three options together always sum to the full released amount.
- All txs are real testnet and surface `ExplorerLink`s.
- If Blend testnet health-check fails on the owner panel load, the `DeFi` card hides and `Mixto` disables with copy "DeFi no disponible; te sugerimos reinvertir en otra anticrético." The `Reinvertir` button in that fallback routes to `E5-02-Rollover`.

### E5-02-Rollover

`/owner/rollover/{propertyId}` — only enabled when a property reaches `Finalizado`.

```
┌──────────────────────────────────────────────────────┐
│ TESTNET · Nav                                        │
├──────────────────────────────────────────────────────┤
│                                                      │
│  Reinvertir en otra anticrético                      │
│                                                      │
│  Al finalizar la anticrético de Sopocachi, puedes    │
│  migrar los holders a otra propiedad en fondeo sin   │
│  que retiren el capital.                             │
│                                                      │
│  Origen                                              │
│  Casa en Sopocachi · 12.000 USDC · 14 holders        │
│                                                      │
│  Destino                                             │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐              │
│  │ Property │ │ Property │ │ Property │              │
│  │ Card     │ │ Card     │ │ Card     │              │
│  │ selected │ │          │ │          │              │
│  └──────────┘ └──────────┘ └──────────┘              │
│                                                      │
│  Al confirmar:                                       │
│  • Se quema la serie actual (12.000 USDC).           │
│  • Se emite una nueva serie en {destino}.            │
│  • Los 14 holders reciben el equivalente en tokens.  │
│                                                      │
│  [RiskDisclosure rollover-migrate]                   │
│                                                      │
│  [Secondary Cancelar] [Primary "Firmar migración"]   │
└──────────────────────────────────────────────────────┘
```

Confirm modal on primary: free-text `ROLLOVER` + confirm. After submit, loading state, then success with `ExplorerLink` to the composite tx.

Acceptance:
- Origin is read-only (the current `Finalizado` property).
- Destination picker shows only `En fondeo` properties whose remaining target is ≥ origin balance.
- Rollover-migrate risk block is present before the primary.
- On success, origin moves to `Finalizado · migrado` (extended label, `text-muted` pill variant), destination funding bar updates in real time, each holder sees new position in dashboard.
- Opt-in per-holder signature is **out of MVP** by design; for the demo, holders are controlled wallets signed in batch from admin credentials. The spec will note this; QA signs off accordingly.
