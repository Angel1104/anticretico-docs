# E3 — Investor dashboard (ANT-DISTRIB + ANT-EXPLORER)

Epic: investor's positions + received distributions view.

## Screens

### E3-01-Investor-dashboard

`/dashboard` — requires auth + wallet.

```
┌──────────────────────────────────────────────────────┐
│ TESTNET banner                                       │
├──────────────────────────────────────────────────────┤
│ Nav                                                  │
├──────────────────────────────────────────────────────┤
│                                                      │
│  Mi dashboard                                        │
│                                                      │
│  ┌─── Resumen ─────────────────────────────────┐     │
│  │ Invertido total      [font-size-money] USDC │     │
│  │ Posiciones activas   {N}                    │     │
│  │ Distribuciones recibidas · variable         │     │
│  │                      [font-size-money] USDC │     │
│  └─────────────────────────────────────────────┘     │
│                                                      │
│  Mis posiciones                                      │
│  ┌──────┐ ┌──────┐ ┌──────┐                          │
│  │ Card │ │ Card │ │ Card │  (PropertyCard compact)  │
│  └──────┘ └──────┘ └──────┘                          │
│                                                      │
│  Historial de distribuciones                         │
│  ┌──────────────────────────────────────────────┐    │
│  │ Fecha    Propiedad      Monto    Tx          │    │
│  │ 15/11/26 Sopocachi      42 USDC  [Explorer]  │    │
│  │ 15/10/26 Sopocachi      42 USDC  [Explorer]  │    │
│  │ ...                                          │    │
│  └──────────────────────────────────────────────┘    │
└──────────────────────────────────────────────────────┘
```

Components: `Nav`, 3-stat summary card (`bg-elevated`, uses `font-size-money` for the two big numbers), compact `PropertyCard` grid, distributions table.

Acceptance:
- "Distribuciones recibidas" row shows the word *variable* within 1 line of the number.
- Each distribution row has an `ExplorerLink` to the tx.
- Positions grid is clickable and routes to each property detail.
- Empty state (no positions yet): illustration placeholder + copy `Aún no tienes inversiones` + primary `Ver propiedades` button linking to `/propiedades`.
