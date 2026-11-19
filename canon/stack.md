# Stack

Allowed technologies and versions. Anything not here needs a spec line and makes the PR at least medium severity.

Approved by Angel on 2026-11-19 (`/approved` on session #1 after `DALE` confirmation of all Tech Lead recommendations).

| Layer | Technology | Version |
|---|---|---|
| Framework (web + server) | Next.js (App Router) | 16.4.x |
| Language | TypeScript | 5.x |
| Styling | Tailwind CSS | 4.3.x |
| Runtime | Node.js | 20 LTS (Vercel default) |
| Database | Supabase (hosted Postgres) | latest hosted |
| Auth | Supabase Auth (OTP email with fixed codes in dev/stage) | latest hosted |
| Realtime | Supabase Realtime | latest hosted |
| Blockchain | `@stellar/stellar-sdk` | ^12 |
| Escrow | Trustless Work SDK (Stellar testnet) | latest |
| Distribution | Pollar SDK (Stellar testnet) | latest |
| DeFi (owner panel) | Blend SDK (Stellar testnet) | latest |
| i18n | `next-intl` (`es-BO`, `en`) | ^3 |
| Unit tests | Vitest | ^2 |
| E2E | Playwright | ^1.48 |
| Hosting (web + API) | Vercel (preview per branch) | — |
| Explorer (URL base) | `stellar.expert/explorer/testnet` | — |

## Do not use

- Mainnet Stellar network passphrase. The code hard-codes `TESTNET` until a post-pilot mainnet epic.
- Ethereum, Algorand, or any non-Stellar chain.
- Third-party KYC providers (manual KYC in MVP).
- `$` currency symbols in UI. USDC suffix only.
- ESLint (disabled at scaffold; `tsc --noEmit` acts as lint for MVP).

## Not yet chosen (post-pilot, out of MVP)

- Payments provider for fiat on-ramp (BOB → USDC).
- Monitoring / error tracking (Sentry is the leading candidate).
- Analytics (post-pilot, needs a privacy review per UIF).
