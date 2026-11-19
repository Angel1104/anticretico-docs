# Anticretico — Design System

## Principles

1. **Transparency over polish.** Every money movement shows an explorer link, a tx hash, and a timestamp. If the user cannot verify it, we do not ship the screen.
2. **Legally first, financially second.** The Derechos Reales milestone is the biggest moment in the UI: large copy, distinct state, admin confirmation modal. Yield numbers never dominate the inscription state visually.
3. **Variable, never promised.** Any yield-shaped number is prefixed "variable" or shown as a historical range. No hero number without the word *variable* within 1 line of it.
4. **Bolivian-native, not translated-from-US.** Use *anticrético*, *Derechos Reales*, *SRL anticresista*, *BOB*, *USDC* as first-class nouns. Do not say "property-backed loan" or "token-backed security"; those are legal re-framings that distort the product.
5. **Dark navy and gold.** The brand is the lien and the inscription, not the token. Navy for seriousness, gold for the moment of value (funding progress, CTAs, inscribed state).

## Voice

- Spanish `es-BO` is primary; English `en` is a second UI language toggle. Never mix inside a label.
- Short, concrete, no financial jargon. "Fondeada" over "capitalised". "Inscrita en Derechos Reales" over "legally recorded".
- Never use "guaranteed", "assured", "fixed yield", "rendimiento garantizado", "renta fija". Every risk-copy block is a required component (`RiskDisclosure`) with a known copy slot — never free-written.

## Rules for builders

- **Tokens only.** No raw colour, spacing, radius or font-size in code. Convert `tokens.json` per stack with a script, never by hand.
- **Components only.** A component not listed under `components/` does not exist. Needing a new one is a stop-and-propose: add it here first, then build.
- **Screens are the reference.** QA compares the running UI against `design/screens/<epic>.md` for layout and against this README for voice. A deviation returns to Product.
- **Explorer link required.** Any screen that renders a tx must render an `ExplorerLink` next to it. No exceptions.
- **Risk disclosure required.** Any screen that has a destructive or legally-sensitive action (`Retirar`, `DeFi`, `Mixto`, `Liberar escrow`, `Distribuir`, `Rollover`) must render a `RiskDisclosure` above the action.

## Layout

- App shell: top nav (72px), content centred at `max-width: 1200px`, page gutter `spacing.8` desktop / `spacing.4` mobile.
- Section rhythm: `spacing.16` between landing sections; `spacing.10` between app sections; `spacing.6` inside a card.
- Grid: 12 columns desktop, 1 column mobile. Property catalog is a 3-column grid (lg) / 2-column (md) / 1-column (sm).

## Locale

- Dates: `DD/MM/YYYY`.
- Numbers: Spanish thousands separator in `es-BO` (`10.000 USDC`); English (`10,000 USDC`) in `en`.
- Currency: always `USDC` (never `$`). BOB equivalent rendered as caption, never as the primary number.
