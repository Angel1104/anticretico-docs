# Data model

Supabase Postgres. Tables kept minimal for the MVP; tx hashes are the source of truth on-chain, Postgres is the cache that powers the UI and real-time state transitions.

| Entity | Owner (module) | Key fields | Personal data? |
|---|---|---|---|
| `users` (Supabase Auth) | `src/lib/auth` | `id`, `email`, `role` (`investor` / `owner` / `admin`), `kyc_status` (`none` / `pending` / `approved` / `rejected`), `wallet_public_key` | yes — email + KYC files (stored in Supabase Storage bucket `kyc`, not public) |
| `properties` | `src/lib/db/properties` | `id`, `slug`, `state` (`En fondeo`/`En trámite`/`Buscando inquilino`/`Alquilado`/`Finalizado`), `ciudad`, `barrio`, `address`, `target_usdc`, `rent_monthly_usdc`, `duration_months`, `owner_user_id`, `escrow_address`, `token_series_code`, `images_urls[]`, `dr_inscription_date`, `created_at` | no (addresses are public) |
| `positions` | `src/lib/db/positions` | `id`, `property_id`, `investor_user_id`, `token_series_code`, `tokens_held`, `usdc_invested`, `deposited_tx`, `created_at` | no |
| `distributions` | `src/lib/db/distributions` | `id`, `property_id`, `period_month`, `gross_usdc`, `fee_usdc` (15%), `net_usdc`, `holders_count`, `pollar_tx`, `created_at` | no |
| `escrow_events` | `src/lib/db/escrow` | `id`, `property_id`, `kind` (`funded`/`released`/`returned`), `usdc_amount`, `trustless_tx`, `dr_milestone_validated_at`, `admin_user_id` | no |
| `owner_actions` | `src/lib/db/owner` | `id`, `property_id`, `kind` (`withdraw`/`defi_deposit`/`mixed`), `withdraw_usdc`, `defi_usdc`, `defi_protocol` (`blend`), `tx` | no |
| `rollovers` | `src/lib/db/rollovers` | `id`, `source_property_id`, `target_property_id`, `holders_migrated`, `composite_tx`, `created_at` | no |

## Rules

- **Tx hash is law.** Every row that represents on-chain state (`positions.deposited_tx`, `escrow_events.trustless_tx`, `distributions.pollar_tx`, `owner_actions.tx`, `rollovers.composite_tx`) is the authoritative pointer. If Postgres and on-chain disagree, on-chain wins and a reconcile job flags the row.
- **State transitions are DB-driven for UI, chain-driven for truth.** A property's `state` column is updated by the admin's on-chain action; a Supabase trigger fires the Realtime broadcast that the catalog subscribes to.
- **No raw secret keys in DB.** Only public keys, addresses, and tx hashes.
- **KYC files** live in Supabase Storage bucket `kyc` with RLS: only the user and the admin role can read.
- **RLS on every table.** No table has the `anon` or `authenticated` role unlocked by default; policies are explicit per operation.

## Initial seed (for dev and stage)

- 6 properties in varied states (at least one `En fondeo`, one `En trámite`, one `Alquilado`, one `Finalizado`).
- 14 pre-funded testnet wallets split across `qa+investor-N@anticretico.test` addresses.
- 1 admin (`admin@anticretico.test`) and 2 owners (`owner+1@`, `owner+2@`).
