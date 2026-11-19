# Input

Text / number / OTP field.

## When to use

- Investment amount (number), admin free-text confirmation, OTP in auth.
- Not for selecting from a list — that is `Select` (not in MVP, add later).

## Anatomy

- Label above (optional): `font-size-sm` 14 / `color.text-secondary` / `font-weight-medium`, gap `spacing.2`.
- Field: height 44, padding-x `spacing.4`, `bg-elevated-2`, 1px border `color.border`, `radius.sm`.
- Focus border: `color.border-strong`, plus `shadow.focus-ring`.
- Error border: `color.state-danger`, with an error message under: `font-size-xs` 12 / `color.state-danger`.
- Helper caption (optional): `font-size-xs` 12 / `color.text-muted`.
- Right adornment slot: for a USDC suffix badge or a "Max" ghost button.

## Variants

| Variant | When |
|---|---|
| `text` | Default. |
| `number-usdc` | Investment amount. Right adornment shows `USDC`. Enforces `>= 1000`. |
| `otp` | Auth. 6 digits, mono font, centred, `font-size-xl` 24. |

## Caller provides

- `label`, `value`, `onChange`, `variant`, `error`, `helper`, `rightAdornment`.

## Do not

- Do not render a currency prefix (`$`). USDC is a suffix.
- Do not allow decimals finer than 2 for USDC.
