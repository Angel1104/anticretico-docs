# FundingBar

Progress bar showing how much USDC has been raised against the anticrético target.

## When to use

- On every `PropertyCard` whose state is `En fondeo` or `En trámite`.
- On the property detail page as a large hero element.
- Hidden on `Alquilado` and `Finalizado` (those states show rent-collected / rent-returned instead).

## Anatomy

- Track: height 8 (sm) or 12 (lg), `color.bg-elevated-2`, `radius.pill`.
- Fill: `color.gold`, `radius.pill`, animated from 0 to target over `motion.duration-slow`.
- Label line above the bar: `font-size-sm` 14 / `font-weight-medium`, left: `{funded} USDC fondeados`, right: `de {target} USDC` in `color.text-secondary`.
- Caption below the bar: `font-size-xs` 12 / `color.text-secondary`, left: `{n} inversionistas`, right: `{daysLeft} días restantes` (if applicable).

## Sizes

| Size | Track height | When |
|---|---|---|
| `sm` | 8 | Inside `PropertyCard` (catalog) |
| `lg` | 12 | Property detail hero |

## Caller provides

- `funded` (USDC number), `target` (USDC number), `investors` (count), `daysLeft` (optional number), `size` (default `sm`).

## Edge states

- 0% funded: fill is a hairline at left edge; still shows `0 USDC fondeados de {target} USDC`.
- 100% funded: fill reaches end; label above becomes `Fondeada` in `color.gold`; days-left caption hidden.
- Over 100% (never should happen in correct flow): clamp fill at 100% and show a `RiskDisclosure` with the `over-funded` copy key below the bar.

## Do not

- Do not paint the fill in `state-success` green. Gold on navy is the brand; green is reserved for `Alquilado`/`Finalizado`.
- Do not add a tooltip with "expected yield". Yield is shown elsewhere with the word *variable*.
