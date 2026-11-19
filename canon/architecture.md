# Architecture

- **Components and repos:**
  - `Angel1104/anticretico` — single Next.js 16 monorepo (web + server routes + server actions). App Router with route groups per audience: `src/app/(public)` landing + catalog, `src/app/(investor)` dashboard + invest flow, `src/app/(admin)` admin, `src/app/(owner)` owner + rollover.
  - `Angel1104/anticretico-docs` — process, canon, specs, design.
- **Who calls whom:**
  - Browser → Next.js App Router (RSC + client components).
  - Server actions / API routes → Supabase (Postgres, Auth, Realtime) and Stellar testnet via `@stellar/stellar-sdk`.
  - Stellar-side flows: deposits enter Trustless Work escrow; admin releases escrow; Pollar distributes rent; Blend holds DeFi balances when the owner opts in.
  - No third-party fiat / KYC services in MVP.

## Severity path patterns (`model/severity.md`)

| Signal | Paths / patterns |
|---|---|
| Migrations | `supabase/migrations/**` |
| Auth | `src/lib/auth/**`, `src/middleware.ts`, Supabase Auth config |
| Payments / legal / personal data | `src/lib/escrow/**`, `src/lib/distribution/**`, `src/lib/defi/**`, `src/lib/stellar/**`, `src/i18n/**/legal.json`, `src/components/RiskDisclosure/**` |
| Infrastructure | `.github/**`, `vercel.json`, `next.config.ts`, `tailwind.config.ts` |
| Config / flags / env | `.env.*`, `src/config/**` |

Anything matching one of those rows forces at least `sev:med`.

## Shared registry files (parallel epics may add entries)

Conflicts resolved by keeping both sides (`model/branches.md` rule 6).

| File | What it registers |
|---|---|
| `src/app/**/page.tsx` + route groups | Routes (App Router convention; new page per feature, not a central registry) |
| `src/i18n/es-BO.json`, `src/i18n/en.json` | Texts per locale, including the 9 fixed `RiskDisclosure` copy keys |
| `src/components/index.ts` | Component re-exports (central barrel) |
| `src/lib/stellar/network.ts` | Network passphrase + horizon URL (locked to testnet) |
| `canon/modules.md` | Logical modules (in the docs repo) |

## Testnet guards

- `src/lib/stellar/network.ts` is the only place `NETWORK_PASSPHRASE` is set. It is hard-coded to `Test SDF Network ; September 2015`. Any other value is a defect caught by a test.
- `src/components/ExplorerLink` prefixes URLs with `https://stellar.expert/explorer/testnet`. Mainnet URL base is not a configurable; it is a product decision requiring a post-pilot epic.
