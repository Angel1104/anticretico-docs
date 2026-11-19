# Nav

Top navigation bar for every app page (not landing — landing has its own simpler nav).

## Anatomy

- Fixed top, height 72, `bg-elevated`, 1px bottom border `color.border`.
- Left: Anticretico logo (gold wordmark, 20 tall).
- Centre: links depending on role.
  - Investor: `Propiedades`, `Mi dashboard`.
  - Owner: `Mis propiedades`, `Panel owner`.
  - Admin: `Validaciones`, `Distribuciones`, `Propiedades`.
- Right:
  - Locale toggle (`ES` | `EN`), ghost.
  - Wallet chip if connected: shows mono-truncated public key + chevron; click opens drawer with `Desconectar` and `Copiar`.
  - If not connected: `primary` Button sm "Conectar wallet".

## Rules

- Role is derived from auth (investor/owner/admin). Users with more than one role see a role switcher inside the wallet chip drawer.
- Testnet banner: a `state-warning` strip sits above the Nav on every app page: `Testnet · USDC de prueba, sin valor real`. 24 tall, centred, `font-size-xs` / `font-weight-medium`.

## Do not

- Do not hide the testnet banner. It is required until mainnet ships.
