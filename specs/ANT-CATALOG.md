# ANT-CATALOG — Property catalog with live state + funding bar

- Request: #3 · Design approved: `design/screens/E1-catalog.md` (E1-01-Landing, E1-02-Catalog, E1-03-Property-detail) · Severity (declared): Medium

## What (never how)

Ship the three public screens that let a visitor see the Anticretico MVP: a landing explaining the model, a catalog of properties with live state, and a detail view with the funding bar and the Invertir CTA (disabled; ANT-INVEST fills it). Everything reads live from Supabase; state transitions push into the UI in real time. Also stand up the shared infra that other epics will reuse: Tailwind-v4 + tokens sync, next-intl with `es-BO` + `en`, Supabase client, 6-property seed.

## Acceptance criteria and test cases

| AC | Criterion | Test case (steps → expected) | Automated? |
|---|---|---|---|
| AC-1 | `/` landing renders hero, how-it-works strip, and 3 featured PropertyCards | Hit `/` → hero shows exact copy "Rendimiento variable."; how-it-works shows 4 numbered items; 3 PropertyCards render | Yes (Playwright) |
| AC-2 | `/propiedades` catalog renders at least 6 properties from the DB in a 3-col grid (lg) | Seed loaded → navigate to `/propiedades` → 6+ PropertyCards visible, each with StatePill, address, FundingBar sm, Ver detalles link | Yes (Playwright) |
| AC-3 | At least one seeded property is in `En trámite` state with the gold pill | Visual inspection: find the gold-pill card in /propiedades | Yes (Playwright + axe snapshot) |
| AC-4 | `/propiedades/{slug}` detail renders StatePill, address, image gallery, anticrético card with FundingBar lg, two RiskDisclosure blocks, Invertir button | Hit `/propiedades/sopocachi-la-paz` → all listed elements present, "variable" appears within 1 line of the rent row | Yes (Playwright) |
| AC-5 | Invertir button is disabled when the state is not `En fondeo` | For a property in `Alquilado`, the primary button is disabled | Yes (Playwright) |
| AC-6 | Testnet banner is visible on every app page (catalog + detail), not on landing | Visual + element check: banner present at `/propiedades`, absent at `/` | Yes (Playwright) |
| AC-7 | Catalog updates in real time when a property's state changes in the DB | Playwright: open `/propiedades` → via Supabase admin API, UPDATE one property's state En fondeo→En trámite → the pill on that card changes without page reload within 3 seconds | Yes (Playwright + Supabase test client) |
| AC-8 | Locale switcher works and swaps all visible copy | Click `EN` in Nav → "Propiedades" becomes "Properties", RiskDisclosure uses the English copy keys | Yes (Playwright) |
| AC-9 | FundingBar renders 0%, partial, and 100% correctly | Seed covers each case; snapshots match | Yes (Vitest snapshot) |
| AC-10 | Tokens come only from CSS variables | `grep "#[0-9a-fA-F]\{6\}"` in `src/components/` and `src/app/` returns zero hits (except in `tokens.css` itself) | Yes (CI script) |
| AC-11 | All visible text is in `src/i18n/{es-BO,en}.json` (no hard-coded strings) | A test scans JSX for string literals in JSX children/attrs; fails if any outside a whitelist | Yes (lint script) |

## Corridor

### Files and areas it may touch

**Infra scaffolding (shared with every later epic)**
- `scripts/sync-tokens.ts` (new; if ANT-EXPLORER ships this first, merge in — do not overwrite)
- `src/styles/tokens.css` (append tokens; if ANT-EXPLORER touched it, append-merge)
- `src/app/globals.css` (import tokens, set `bg` + base font)
- `src/lib/db/supabase.ts` (new; client factory using `NEXT_PUBLIC_SUPABASE_URL` + `NEXT_PUBLIC_SUPABASE_ANON_KEY`)
- `src/lib/db/types.ts` (new; generated Supabase types or hand-typed `Database` interface)
- `src/i18n/es-BO.json` (new, default)
- `src/i18n/en.json` (new)
- `src/i18n/request.ts` (new; next-intl request config)
- `src/middleware.ts` (new; next-intl locale detection)
- `next.config.ts` (adjust: register next-intl plugin)
- `tailwind.config.ts` — Tailwind v4 uses `@theme` in CSS; no JS config needed. Use `@theme inline` in `tokens.css` mapping CSS vars.

**Supabase schema**
- `supabase/migrations/0001_init.sql` (new; `properties` table per `canon/data-model.md`; indexes on `slug`, `state`, `ciudad`)
- `supabase/seed.sql` (new; 6 properties covering `En fondeo`, `En trámite` ×2, `Buscando inquilino`, `Alquilado`, `Finalizado`)

**Components (mirror `/Users/angel/Ventures/anticretico-docs/design/system/components/`)**
- `src/components/Button/Button.tsx` + `.test.tsx`
- `src/components/StatePill/StatePill.tsx` + `.test.tsx`
- `src/components/FundingBar/FundingBar.tsx` + `.test.tsx`
- `src/components/PropertyCard/PropertyCard.tsx` + `.test.tsx`
- `src/components/RiskDisclosure/RiskDisclosure.tsx` + `.test.tsx` (ships only the 2 keys needed here: `invest-variable-yield`, `invest-testnet`)
- `src/components/Nav/Nav.tsx` + `.test.tsx` (role-less view for this epic — public nav only)
- `src/components/index.ts` (barrel; append if ANT-EXPLORER created it first)

**Routes (App Router)**
- `src/app/[locale]/(public)/layout.tsx` (public layout: landing nav, no testnet banner)
- `src/app/[locale]/(public)/page.tsx` (landing)
- `src/app/[locale]/(app)/layout.tsx` (app layout: role-less Nav + testnet banner)
- `src/app/[locale]/(app)/propiedades/page.tsx` (catalog with Realtime subscription)
- `src/app/[locale]/(app)/propiedades/[slug]/page.tsx` (detail)

**E2E**
- `playwright.config.ts` (new)
- `e2e/catalog.spec.ts` (new; covers AC-1 through AC-8)

### Migrations
Yes — `supabase/migrations/0001_init.sql`. Applied via Supabase CLI against project ref `qrghrfyomuxswgtswkrd` as part of the epic's CI/dev deploy. Seed loaded via `supabase db seed` after migration.

### New dependencies
- `@supabase/supabase-js ^2`
- `next-intl ^3`
- `@playwright/test ^1.48`
- Vitest stack from ANT-EXPLORER if that epic shipped it; otherwise add in this epic

### Binding decisions
- **Tailwind v4 config lives in `tokens.css` via `@theme inline`.** No `tailwind.config.ts`. Values map `--color-bg`, `--color-gold`, etc. to Tailwind utilities like `bg-background`, `text-gold`.
- **`[locale]` route group.** Using next-intl's App Router pattern. `es-BO` is the default locale; `en` is the alternate.
- **Public landing has its own nav.** The regular `Nav` (with testnet banner) is for app routes only.
- **Realtime subscription is client-side.** Server renders the initial state from Supabase; client component subscribes to the `properties` table changes and triggers a re-fetch of the affected row.
- **No filters in v0.** Locked by `decisions/001-design-trade-offs.md`. A stop-and-report if the executor tries to add filter chips.
- **Images for seed properties:** use `/public/seed/*.jpg` placeholder images (a 1200x800 colour-blocked gradient per property — cheap, no external dependency). The executor commits them.

### Reuse
- `<ExplorerLink>` from `src/components/ExplorerLink` if ANT-EXPLORER has merged by the time this epic reaches the property-detail history-section AC — otherwise show a disabled placeholder row and note it in the result report.
- CSS vars from `src/styles/tokens.css` (produced by `scripts/sync-tokens.ts` reading from `/Users/angel/Ventures/anticretico-docs/design/system/tokens.json`).

## Tickets

| Ticket | Repo | Files | Can run in parallel with |
|---|---|---|---|
| ANT-CATALOG-1 (whole) | anticretico | All files listed above | ANT-EXPLORER (append-merge-safe conflicts on `src/components/index.ts`, `src/styles/tokens.css`, `package.json`) |

Single-ticket epic. One PR `epic/ANT-CATALOG` → `main`.
