# StatePill

The property lifecycle state, shown wherever a property appears.

## When to use

- On every `PropertyCard`, on the property detail header, in investor dashboard rows, in admin tables.
- **Never** for anything other than the five canonical states below.

## Variants (one per state)

| State | Background | Text | Dot colour |
|---|---|---|---|
| `En fondeo` | `color.state-info` at 15% alpha | `color.state-info` | `color.state-info` |
| `En trámite` | `color.gold` at 15% alpha | `color.gold` | `color.gold` |
| `Buscando inquilino` | `color.state-info` at 15% alpha | `color.state-info` | `color.state-info` |
| `Alquilado` | `color.state-success` at 15% alpha | `color.state-success` | `color.state-success` |
| `Finalizado` | `color.text-muted` at 15% alpha | `color.text-muted` | `color.text-muted` |

`En trámite` is the only state painted in gold — it marks the Derechos Reales inscription window, the brand-defining moment.

## Shape

- Pill: `radius.pill`, height 24, padding-x `spacing.3` (12).
- Left dot: 6×6 circle, dot colour, gap `spacing.2` (8) to the label.
- Font: `font-size-xs` 12 / `font-weight-medium`, uppercase first letter, rest sentence case.

## Caller provides

- `state`: one of the 5 canonical strings. No free text.

## Do not

- Do not create extra states for edge cases. If the business adds a new state, add a variant here first; a new state is a product decision, not a UI decision.
- Do not animate state changes on the card. State changes are shown by re-rendering the pill, not pulsing.
