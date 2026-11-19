# Environments

| Env | URL | Deployed from | Test accounts |
|---|---|---|---|
| dev | per-epic Vercel preview (one deployment per `epic/*` branch, URL assigned at push time) | `epic/<KEY>` | Fixed OTP `000000` for any email; wallets: pre-funded testnet accounts seeded by `scripts/seed-testnet.ts` |
| stage | https://anticretico.vercel.app | `main` | Fixed OTP `000000`; same seeded wallets as dev |
| prod | not deployed in MVP (testnet only) — a post-pilot epic adds mainnet + prod URL | tag `vX.Y.Z` (not cut during hackathon) | n/a for pilot |

## Infrastructure IDs (not secrets)

| Service | ID / URL |
|---|---|
| Vercel team | `angel1104s-projects` (`team_okgdCWJnEFOlg7vJ7qJIrl9l`) |
| Vercel project | `anticretico` (`prj_EkV2S5W0N6LOMurpEkjrM1bPRBC8`) |
| Supabase project ref | `qrghrfyomuxswgtswkrd` (region `sa-east-1`, free tier) |
| Supabase URL | https://qrghrfyomuxswgtswkrd.supabase.co |
| Supabase dashboard | https://supabase.com/dashboard/project/qrghrfyomuxswgtswkrd |
| GitHub code repo | https://github.com/Angel1104/anticretico |
| GitHub Project | https://github.com/users/Angel1104/projects/3 |

Env secrets (Supabase anon key, service role key, Stellar network vars) are set on Vercel for `development`, `preview`, and `production` targets. They are NOT committed to any repo. For local dev, `vercel env pull .env.local` from the `anticretico` directory.

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
