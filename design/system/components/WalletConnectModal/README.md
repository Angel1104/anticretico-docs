# WalletConnectModal

Modal to connect a Stellar wallet (testnet in MVP).

## When to use

- On any screen that requires a wallet and the user is not yet connected (Investir, Admin panel, Owner panel).
- Triggered by a `primary` Button with the label "Conectar wallet".

## Anatomy

- Modal with `shadow.modal`, `radius.lg`, `bg-elevated`, max-width 420, padding `spacing.8`.
- Title: "Conectar wallet" — `font-size-xl` 24 / `font-weight-bold`.
- Subtitle: "Testnet de Stellar. No uses fondos reales." — `font-size-sm` 14 / `color.state-info`.
- Three wallet rows (vertical stack, gap `spacing.3`):
  - `Freighter` (recommended, logo, tag "Recomendado" in gold)
  - `xBull`
  - `LOBSTR`
- Each row: `bg-elevated-2`, `radius.md`, padding `spacing.4`, 56 tall, logo-left, name-centre, chevron-right. Hover → `border-strong`.
- Footer: Ghost `Button` "¿No tienes wallet? Crea una en Freighter" — opens Freighter install in new tab.

## Flow

1. User clicks a wallet row → extension detection.
2. If not installed → inline hint under the row linking to install page; row goes to disabled state.
3. If installed → wallet opens; on success, modal closes and triggers `onConnected(publicKey)`.
4. After connect, the connecting screen must verify the wallet is on `TESTNET` network passphrase; if not, show a secondary modal "Cambia a Testnet" with instructions. **No mainnet in MVP.**

## Caller provides

- `onConnected(publicKey)`, `onDismiss`.

## Risk disclosure

- Fixed copy at the bottom before the install link: "Al conectar, autorizas a Llavero a leer tu wallet. Nunca pedimos tu frase semilla." — `font-size-xs` 12 / `color.text-muted`.

## Do not

- Do not auto-connect silently. Every session requires explicit click.
- Do not let the modal close if the wallet is on the wrong network; force the user to switch or dismiss.
