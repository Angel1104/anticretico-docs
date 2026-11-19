# RiskDisclosure

Required risk-copy block shown before any destructive or legally-sensitive action.

## When to use

- **Required** before: `Invertir`, `Retirar`, `DeFi`, `Mixto`, `Liberar escrow`, `Distribuir`, `Rollover`.
- Also used as inline warning on property detail where yield numbers appear.

## Anatomy

- Horizontal block, `bg-elevated-2`, 1px border `color.state-danger` at 40% alpha, `radius.md`, padding `spacing.4`.
- Left icon: `⚠` (or a lucide `AlertTriangle`), 20×20, `color.state-danger`.
- Text: `font-size-sm` 14 / `color.text-primary`, inside tight 2-line block.
- Optional "Más información" ghost link on the right side, opens a dialog with the long version.

## Copy keys (fixed, not free-written)

| Key | Copy (es-BO) |
|---|---|
| `invest-variable-yield` | El rendimiento es variable. Depende del alquiler, la zona y la ocupación. Nunca garantizado. |
| `invest-testnet` | Estás operando en Stellar Testnet. Los USDC son de prueba, sin valor real. |
| `withdraw-cash` | Al retirar, los USDC salen del sistema. Pierdes exposición al alquiler futuro de este anticrético. |
| `defi-protocol-risk` | El protocolo DeFi puede fallar o ser hackeado. Anticretico no cubre pérdidas on-chain. |
| `mixed-split` | Divides tu capital entre retiro y DeFi. Cada parte asume su propio riesgo. |
| `release-escrow` | Al liberar, el escrow se envía al dueño. Solo haz esto después de confirmar la inscripción en Derechos Reales. |
| `distribute-monthly` | Esta distribución es irreversible. Los USDC se envían a los holders en una única transacción. |
| `rollover-migrate` | Migrar holders a otra propiedad implica quemar los tokens actuales y emitir nuevos. No se puede deshacer. |
| `over-funded` | Esta propiedad excedió su objetivo. El sobrante se reembolsará a los últimos inversionistas. |

Each key has an English mirror in `en`. Copy edits here require a product change.

## Caller provides

- `copyKey`: one of the above. No free text.
- Optional `onMore` to open the long-version dialog.

## Do not

- Do not use a `RiskDisclosure` for marketing / non-risk informational copy. That is a different component (not in MVP).
- Do not stack more than one `RiskDisclosure` next to the same action. Compose a new key instead.
