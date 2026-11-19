# ExplorerLink

Chip linking to a Stellar testnet explorer for a specific tx or address.

## When to use

- **Required** wherever a tx hash or Stellar address appears to the user: deposit receipt, release confirmation, distribution success toast, investor dashboard rows, admin audit trail.
- Never use a plain anchor for a tx — always this component.

## Anatomy

- Chip, `radius.sm`, `bg-elevated-2`, padding `spacing.2 spacing.3`, gap `spacing.2`.
- Left icon: small Stellar logo (16×16), no colour recolouring.
- Text: truncated hash/address in `font-family-mono`, `font-size-sm` 14 / `color.text-secondary`. Shows first 6 and last 4 chars with `…` in the middle. Full value on hover tooltip and in `title` attribute.
- Right icon: external-link arrow (14×14), `color.text-secondary`.

## Behaviour

- Click opens `https://stellar.expert/explorer/testnet/tx/{hash}` or `/account/{addr}` in a new tab.
- Hover: background `border-strong`; text goes to `color.text-primary`.
- Right-click → copy hash/address.

## Caller provides

- `kind`: `"tx"` | `"account"`.
- `value`: the full hash or address.

## Do not

- Do not render an `ExplorerLink` for a pending tx. Wait for the hash before showing it; until then show a loading state inline.
- Do not link to mainnet explorer in MVP (testnet-only). This is enforced in the component: the URL base is fixed to `stellar.expert/explorer/testnet`.
