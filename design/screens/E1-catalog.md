# E1 — Catalog (ANT-CATALOG)

Epic: property catalog with live state + funding bar.

## Screens

### E1-01-Landing

Public home at `/`. No auth, no testnet banner (landing is marketing).

```
┌────────────────────────────────────────────────────────┐
│ [Anticretico]              [ES EN]   [Conectar wallet] │
├────────────────────────────────────────────────────────┤
│                                                        │
│    Invierte en anticréticos bolivianos                 │
│    desde 1.000 USDC.                                   │
│                                                        │
│    Rendimiento variable. Protegido por                 │
│    Derechos Reales. On-chain en Stellar.               │
│                                                        │
│    [Ver propiedades] [Soy propietario]                 │
│                                                        │
├────────────────────────────────────────────────────────┤
│   Cómo funciona                                        │
│   1. Un propietario pone su casa en anticrético.       │
│   2. Inversionistas aportan USDC a un escrow.          │
│   3. Se inscribe en Derechos Reales → se libera.       │
│   4. La renta mensual se distribuye a los holders.     │
├────────────────────────────────────────────────────────┤
│   [Propiedades destacadas — 3 PropertyCard]            │
└────────────────────────────────────────────────────────┘
```

Components: landing-only nav (simpler), hero, step strip (4 numbered items), 3 `PropertyCard` grid (reusing the catalog component), footer.

Acceptance:
- Hero shows the exact copy: "Rendimiento variable."
- 3 PropertyCards link to their detail pages.
- "Soy propietario" routes to the owner listing flow (out of MVP → placeholder page with "Próximamente").

### E1-02-Catalog

Investor catalog at `/propiedades`. Auth optional (browse anonymously, but investing requires auth + wallet).

```
┌────────────────────────────────────────────────────────┐
│  TESTNET · USDC de prueba, sin valor real              │
├────────────────────────────────────────────────────────┤
│ [Nav — Propiedades · Mi dashboard · wallet right]      │
├────────────────────────────────────────────────────────┤
│                                                        │
│  Propiedades                                           │
│  {N} propiedades · filtradas por {ciudad}              │
│                                                        │
│  (filtros out of v0 — see decisions/001)               │
│                                                        │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐              │
│  │ Property │  │ Property │  │ Property │              │
│  │ Card     │  │ Card     │  │ Card     │              │
│  └──────────┘  └──────────┘  └──────────┘              │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐              │
│  │ Property │  │ Property │  │ Property │              │
│  │ Card     │  │ Card     │  │ Card     │              │
│  └──────────┘  └──────────┘  └──────────┘              │
└────────────────────────────────────────────────────────┘
```

Components: `Nav`, `PropertyCard` grid. **No filters in v0** — decision locked in `decisions/001-design-trade-offs.md`. Filters (`Ciudad` / `Estado` / `Ticket mínimo`) ship as a post-pilot epic once the `Select` component is added to the system.

Acceptance:
- Grid renders at least 6 properties with varied states.
- Testnet banner is visible.
- Clicking any card routes to `/propiedades/{slug}`.
- At least one property is in `En trámite` state to show the gold pill in context.

### E1-03-Property-detail

`/propiedades/{slug}`.

```
┌────────────────────────────────────────────────────────┐
│ TESTNET banner                                         │
├────────────────────────────────────────────────────────┤
│ Nav                                                    │
├────────────────────────────────────────────────────────┤
│  ← Volver                                              │
│                                                        │
│  [StatePill En trámite]                                │
│                                                        │
│  Casa en Sopocachi, La Paz                             │
│  Av. 20 de Octubre #1234                               │
│                                                        │
│  ┌─────── Image gallery (3:2, 600 tall) ─────────┐     │
│  └──────────────────────────────────────────────┘      │
│                                                        │
│  ┌─── Anticrético ────────────────────────────┐        │
│  │ Objetivo         12.000 USDC               │        │
│  │ Fondeado         8.400 USDC                │        │
│  │ Alquiler mensual 320 USDC/mes · variable   │        │
│  │ Plazo            24 meses                  │        │
│  │ [FundingBar size="lg"]                     │        │
│  │ 14 inversionistas · 6 días restantes       │        │
│  │ [RiskDisclosure copyKey="invest-variable..."]│      │
│  │ [RiskDisclosure copyKey="invest-testnet"]  │        │
│  │ [Button primary lg "Invertir"]             │        │
│  └────────────────────────────────────────────┘        │
│                                                        │
│  Detalles                                              │
│  • Tipo: casa unifamiliar · 180 m²                     │
│  • Zona: Sopocachi                                     │
│  • Inquilino actual: familia (si Alquilado)            │
│                                                        │
│  Documentos                                            │
│  • Minuta de anticrético — [ExplorerLink no, PDF link] │
│  • Certificado Derechos Reales — pendiente             │
│                                                        │
│  Historial on-chain                                    │
│  • Serie emitida · [ExplorerLink tx]                   │
│  • Inversión #1 · 1.000 USDC · [ExplorerLink tx]       │
│  • ...                                                 │
└────────────────────────────────────────────────────────┘
```

Components: `Nav`, back link, `StatePill`, address header, image gallery (3:2 main + 3 thumbnails), anticrético card with `FundingBar` + 2 `RiskDisclosure`s + primary `Button`, details list, document list, on-chain history (`ExplorerLink` per row).

Acceptance:
- "Invertir" button is `disabled` if the state is not `En fondeo`.
- The `invest-variable-yield` and `invest-testnet` risk blocks are both present before the button.
- At least 2 `ExplorerLink` rows appear in the history for a funded property.
- The word "variable" appears next to the monthly rent.
