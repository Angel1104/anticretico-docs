# Environments

| Env | URL | Deployed from | Test accounts |
|---|---|---|---|
| dev | per-epic Vercel preview (one deployment per `epic/*` branch) | `epic/<KEY>` | Fixed OTP `000000` for any email; wallets: pre-funded testnet accounts seeded by `scripts/seed-testnet.ts` |
| stage | `anticretico.vercel.app` | `main` | Fixed OTP `000000`; same seeded wallets as dev |
| prod | not deployed in MVP (testnet only) — a post-pilot epic adds mainnet + prod URL | tag `vX.Y.Z` (not cut during hackathon) | n/a for pilot |

Deploy platform: **Vercel** (web + API + server actions). Supabase hosts Postgres, Auth, and Realtime across all envs.

## Chain environment

All envs — dev, stage, and a hypothetical prod — operate on **Stellar testnet** for the hackathon. Mainnet is a post-pilot epic (requires the SRL anticresista to be fully set up and KYC/UIF compliance signed off).

- Horizon URL: `https://horizon-testnet.stellar.org`
- Network passphrase: `Test SDF Network ; September 2015`
- Explorer: `https://stellar.expert/explorer/testnet`
- Trustless Work, Pollar, and Blend: their testnet deployments.

## Secrets

| Env | Where |
|---|---|
| dev | `.env.dev` (shared) in `anticretico` repo; also set in Vercel per-preview |
| stage | `.env.stage` + Vercel production env mapped to `main` |
| prod | Vercel production env (empty until mainnet epic) |

- `.env.local` is personal / git-ignored.
- No secret is logged. The Vercel preview URL on each PR is the only place dev state is observed.

## QA auth

- Email OTP in dev and stage uses Supabase "test OTP" feature with a single fixed code `000000` accepting any address matching `qa+*@anticretico.test`. Any other address goes through real email delivery.
- Admin role is granted to `admin@anticretico.test` via a seed migration in `supabase/seed.sql`.
- Owner role is granted to `owner+*@anticretico.test`.
