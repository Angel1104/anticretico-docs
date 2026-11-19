# ANT-EXPLORER — Stellar explorer link per transaction

- Request: #7 · Design approved: `design/system/components/ExplorerLink/README.md` · Severity (declared): Medium

## What (never how)

Ship the `<ExplorerLink>` React component that every other epic must use whenever a Stellar transaction hash or Stellar account address appears in the UI. Cross-cutting, runs in parallel with ANT-CATALOG. The component must be visually complete per the design-system README, testnet-locked by construction, and importable from `@/components`.

## Acceptance criteria and test cases

| AC | Criterion | Test case (steps → expected) | Automated? |
|---|---|---|---|
| AC-1 | Component renders a truncated tx hash like `6f5a2c…a9b4` and opens the testnet explorer when clicked | Render `<ExplorerLink kind="tx" value="6f5a2c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3a9b4" />` → chip shows `6f5a2c…a9b4`, click opens `https://stellar.expert/explorer/testnet/tx/6f5a2c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3a9b4` in a new tab | Yes (Vitest + jsdom) |
| AC-2 | Same for account addresses | Render `<ExplorerLink kind="account" value="GABC123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ012345" />` → URL starts with `/account/` | Yes |
| AC-3 | Stellar logo + external-link icon are rendered inline | Snapshot shows both SVGs present | Yes |
| AC-4 | The explorer base URL is hard-coded to testnet; mainnet URL is never emitted | A test that mocks `NEXT_PUBLIC_EXPLORER_BASE_URL` to a mainnet value still emits a testnet URL (the component ignores the env for the base; it is a constant inside the module) | Yes |
| AC-5 | Full value appears in `title` attribute (for hover/copy) | `title` equals the full hash/address | Yes |
| AC-6 | Component is exported from `src/components/index.ts` barrel | `import { ExplorerLink } from '@/components'` resolves | Yes (TS compile) |
| AC-7 | Tokens come from CSS variables (no raw hex) | Visual check + snapshot does not contain `#` hex literals in rendered CSS custom properties | Yes (snapshot) |

## Corridor

- Files and areas it may touch:
  - `src/components/ExplorerLink/ExplorerLink.tsx` (new)
  - `src/components/ExplorerLink/ExplorerLink.test.tsx` (new)
  - `src/components/index.ts` (new; create barrel)
  - `src/styles/tokens.css` (new; minimum tokens needed by this component — can be a subset for now, the rest comes with ANT-CATALOG)
  - `src/app/globals.css` (import `tokens.css`)
  - `scripts/sync-tokens.ts` (new; script that converts `/Users/angel/Ventures/anticretico-docs/design/system/tokens.json` into `src/styles/tokens.css` as CSS custom properties)
  - `package.json` (add `vitest`, `@vitest/ui`, `@testing-library/react`, `@testing-library/jest-dom`, `jsdom` as devDependencies; add `test`, `test:watch`, `sync:tokens` scripts)
  - `vitest.config.ts` (new)
  - `tsconfig.json` (adjust if Vitest types need the `vitest/globals` reference)
- Migrations: none
- New dependencies: `vitest ^2`, `@vitest/ui`, `@testing-library/react ^16`, `@testing-library/jest-dom`, `jsdom`
- Binding decisions:
  - Explorer base URL is a **module constant** inside `ExplorerLink.tsx`, NOT an env var. Rationale: AC-4 is a safety invariant. Mainnet must be a product decision, not a config twist.
  - Truncation format: first 6 chars + `…` + last 4 chars (per design-system README).
  - Right-click to copy is not implemented in this epic (it is an OS behaviour on the `title` attribute); shipping the full `title` is enough.
- Reuse: n/a (first component of the system to be built)

## Tickets

| Ticket | Repo | Files | Can run in parallel with |
|---|---|---|---|
| ANT-EXPLORER-1 (whole) | anticretico | All files listed above | ANT-CATALOG (shared files: `src/components/index.ts` — add entry only, append-merge-safe; `src/styles/tokens.css` — both epics will touch it, merge is append-safe) |

Single-ticket epic. One PR `epic/ANT-EXPLORER` → `main`.
