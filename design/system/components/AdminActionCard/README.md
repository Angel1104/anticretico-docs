# AdminActionCard

The admin-only action blocks that fire real on-chain txs (validate DR, release escrow, distribute).

## When to use

- Admin panel only, never shown to investors or owners.
- One `AdminActionCard` per action. Group under a tab if more than 3 appear per screen.

## Anatomy

- Card: `bg-elevated`, `radius.md`, 1px border `color.border-strong`, padding `spacing.6`.
- Header: title (`font-size-lg` 18 / `font-weight-semibold`) + subtitle (`color.text-secondary`).
- Body: a small `summary` block with the 3 data points relevant to the action (e.g. for release: "Propiedad", "USDC en escrow", "Wallet del dueño"). Each row: label-left in `text-secondary`, value-right in `text-primary` / `font-weight-medium`.
- Required `RiskDisclosure` with the right `copyKey`.
- Footer: `Button variant="primary"` with the action label. Clicking opens a confirmation modal.

## Confirmation modal

- Modal with `shadow.modal`, `radius.lg`, 420 wide.
- Title: the action in imperative (e.g. "Liberar escrow al dueño").
- Body: repeats the same `summary` block.
- Required `RiskDisclosure` repeated inside the modal.
- A free-text confirmation field: user types the property name (or "LIBERAR" for releases). Button disabled until exact match.
- Buttons: `secondary` Cancelar + `primary` Confirmar.

## After submit

- Button goes to `loading`. On success: toast with success state and an `ExplorerLink` to the tx. On failure: toast with `state-danger`, keep the modal open, show error.

## Caller provides

- `title`, `subtitle`, `summary` rows, `riskCopyKey`, `actionLabel`, `confirmWord`, `onSubmit()`.

## Do not

- Do not skip the free-text confirmation in MVP, even for low-stakes actions. All admin txs on the demo are observable — a wrong click on stage costs the pitch.
