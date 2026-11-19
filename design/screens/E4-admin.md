# E4 — Admin (ANT-ADMIN + ANT-DISTRIB)

Epic: validate Derechos Reales + release escrow; trigger monthly distribution.

## Screens

### E4-01-Admin-panel

`/admin` — gated to admin role only. All other roles get a 403.

Two tabs: `Validaciones` and `Distribuciones`.

```
┌──────────────────────────────────────────────────────┐
│ TESTNET banner                                       │
├──────────────────────────────────────────────────────┤
│ Nav (admin links: Validaciones · Distribuciones)     │
├──────────────────────────────────────────────────────┤
│                                                      │
│  Panel admin                                         │
│                                                      │
│  [Tab: Validaciones] [Tab: Distribuciones]           │
│                                                      │
│  ── Tab 1: Validaciones ────────────────────────     │
│                                                      │
│  Propiedades en trámite                              │
│                                                      │
│  ┌─── AdminActionCard ─────────────────────────┐     │
│  │ Casa en Sopocachi, La Paz                   │     │
│  │ Esperando inscripción en Derechos Reales    │     │
│  │                                             │     │
│  │ Propiedad      Casa en Sopocachi            │     │
│  │ USDC en escrow 12.000                       │     │
│  │ Wallet owner   GOWN…A9                      │     │
│  │                                             │     │
│  │ [RiskDisclosure release-escrow]             │     │
│  │ [Button primary "Liberar escrow"]           │     │
│  └─────────────────────────────────────────────┘     │
│                                                      │
│  ┌─── AdminActionCard ─ otra propiedad ────────┐     │
│  │ ...                                         │     │
│  └─────────────────────────────────────────────┘     │
│                                                      │
│  ── Tab 2: Distribuciones ──────────────────────     │
│                                                      │
│  Propiedades Alquiladas                              │
│                                                      │
│  ┌─── AdminActionCard ─────────────────────────┐     │
│  │ Casa en Sopocachi                           │     │
│  │ Alquiler recibido este mes                  │     │
│  │                                             │     │
│  │ Alquiler mes      320 USDC                  │     │
│  │ Comisión plataforma (15%)  48 USDC          │     │
│  │ Neto a distribuir 272 USDC                  │     │
│  │ Holders           14                        │     │
│  │                                             │     │
│  │ [RiskDisclosure distribute-monthly]         │     │
│  │ [Button primary "Distribuir vía Pollar"]    │     │
│  └─────────────────────────────────────────────┘     │
│                                                      │
│  Historial                                           │
│  ┌──────────────────────────────────────────────┐    │
│  │ Fecha   Propiedad    Monto    Holders  Tx    │    │
│  │ 15/11   Sopocachi    272 USDC  14  [Expl.]   │    │
│  └──────────────────────────────────────────────┘    │
└──────────────────────────────────────────────────────┘
```

Components: `Nav` (admin role), tab strip, `AdminActionCard`s stacked, history table.

Confirmation modals (see `AdminActionCard`):
- Liberar escrow: confirmWord = `LIBERAR`. On success: property state transitions `En trámite → Buscando inquilino` in real time, success toast with `ExplorerLink`.
- Distribuir: confirmWord = `DISTRIBUIR`. On success: distribution row appears in history with `ExplorerLink`.

Acceptance:
- Admin can only see this screen if the DB marks them as admin.
- Each action fires a real testnet tx.
- The `release-escrow` risk block appears before every release action.
- The `distribute-monthly` risk block appears before every distribute action.
- The 15% platform fee and the net amount are both shown in the summary, consistent with `canon/product.md`.
