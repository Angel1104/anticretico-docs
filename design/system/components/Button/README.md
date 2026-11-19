# Button

Primary action primitive. Every clickable call-to-action is a `Button` variant.

## When to use

- Submitting a form, opening a modal, triggering a tx, navigating to a flow.
- **Not** for navigation links inside text (use an anchor styled as a link).

## Variants

| Variant | When | Background | Text | Border |
|---|---|---|---|---|
| `primary` | The single most important action on a screen (Invertir, Conectar wallet, Liberar escrow, Distribuir) | `color.gold` | `color.bg` | none |
| `secondary` | Supporting action next to a primary (Cancelar, Ver detalles) | transparent | `color.text-primary` | 1px `color.border-strong` |
| `ghost` | Low-weight actions in cards (Ver en explorer, Copiar) | transparent | `color.text-secondary` | none |
| `danger` | Destructive or risky action (Retirar todo, Rechazar inscripción) | transparent | `color.state-danger` | 1px `color.state-danger` |

## Sizes

| Size | Height | Padding-x | Font |
|---|---|---|---|
| `sm` | 32 | `spacing.3` (12) | `font-size-sm` 14 / `font-weight-medium` |
| `md` | 40 | `spacing.4` (16) | `font-size-base` 16 / `font-weight-semibold` |
| `lg` | 48 | `spacing.6` (24) | `font-size-lg` 18 / `font-weight-semibold` |

Default size is `md`. Only the hero on landing uses `lg`.

## Caller provides

- `variant` (default `primary`), `size` (default `md`), `label`, optional `icon` (left), `onClick`, `disabled`, `loading` (shows spinner, locks button).

## States

- Hover: brighten background one step (`gold → gold-hover`). Secondary/ghost hover: `bg-elevated-2` background.
- Focus: `shadow.focus-ring`.
- Disabled: 50% alpha, cursor not-allowed.
- Loading: spinner replaces icon; label stays but is dimmed to `text-secondary`; button is non-interactive.

## Do not

- Do not stack two `primary` buttons on the same screen. One primary per screen.
- Do not render the word "Garantizar" or "Asegurar" as a label — see voice rules.
