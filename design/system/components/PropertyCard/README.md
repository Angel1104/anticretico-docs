# PropertyCard

A single property in the catalog grid.

## When to use

- The property catalog (3-col lg / 2-col md / 1-col sm).
- The investor dashboard "Mis posiciones" list (compact variant).

## Anatomy

```
┌───────────────────────────────────────┐
│ [image, 16:9, radius.md top corners]  │
├───────────────────────────────────────┤
│ [StatePill]                           │
│                                       │
│ {barrio}, {ciudad}         [gold]     │
│ {address line 1}                      │
│                                       │
│ Anticrético: {target} USDC            │
│ Alquiler: {rent} USDC/mes · variable  │
│                                       │
│ [FundingBar size="sm"]                │
│                                       │
│ ─────────────────────────────────     │
│ [Ver detalles] →                      │
└───────────────────────────────────────┘
```

## Spec

- Container: `bg-elevated`, `radius.md`, `shadow.card`, padding `spacing.6` below the image.
- Image: 16:9 aspect, `object-fit: cover`, rounded top corners only.
- `StatePill` sits above the address, `spacing.3` gap.
- Title row: `font-size-lg` 18 / `font-weight-semibold`. Right-aligned chevron in `color.gold`.
- Finance rows: `font-size-sm` 14 / `color.text-secondary`. The word *variable* is always inside the rent line.
- `FundingBar size="sm"` with `spacing.4` padding above and below.
- Footer action: ghost `Button` with the label "Ver detalles" and a right arrow icon.

## States

- Default, hover (lift: `shadow.modal`, cursor pointer on the whole card), focused (focus ring on the whole card), disabled only when state is `Finalizado`.
- `Finalizado` variant: image goes to 60% brightness, "Finalizada" caption replaces the funding bar, action changes to "Ver historial".

## Caller provides

- `property` object: `{ state, barrio, ciudad, address, imageUrl, targetUsdc, rentMonthlyUsdc, funded, investors, daysLeft }`, `onClick`.
- Compact mode `compact=true` hides the image.

## Do not

- Do not render a yield percentage on the card. It is deliberate; `PropertyDetail` is where numbers go, with their disclaimers.
